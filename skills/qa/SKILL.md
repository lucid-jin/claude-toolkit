---
name: qa
description: QA 검수 에이전트. Linear PRD 기반 또는 URL 직접 검수. /qa ZEP-181 로 PRD에서 시나리오 도출 후 agent-browser 검수, /qa <URL> 로 직접 검수. /qa-login <profile> <url> 로 세션 프로필 등록. 모든 검수는 백그라운드 서브 에이전트로 실행.
allowed-tools: Bash(agent-browser:*), Task, mcp__linear__get_issue, mcp__linear__list_comments, mcp__linear__create_comment
user-invocable-skills:
  - qa: Run QA check based on Linear PRD or URL
  - qa-login: Open headed browser to register/refresh a login session profile
---

# QA 검수 에이전트

## 프로필 목록

| 프로필명 | URL 패턴 | 비고 |
|---------|----------|------|
| zep-admin | admin.zep.us | NextAuth |

> 프로필은 세션(쿠키) 관리 단위. 같은 인증 체계면 환경이 달라도 동일 프로필 사용 가능.
> 프로필에 없는 서비스는 사용자에게 프로필 등록(`/qa-login`) 또는 프로필 없이 접근할지 확인.

## /qa-login

headed 브라우저를 열어 사용자가 직접 로그인. 세션이 프로필에 자동 저장됨.

```bash
agent-browser open <login-url> --profile <name> --headed
# 사용자 로그인 완료 후
agent-browser close
```

## /qa

**반드시 Task tool (run_in_background=true)로 실행.** 메인 세션 블로킹 금지.

### 브라우저 자동화 도구 (필수)

> **절대 `mcp__claude-in-chrome__*` 도구를 사용하지 마세요.**
> 브라우저 조작은 **반드시 `agent-browser` CLI 명령어를 Bash 도구로 실행**합니다.
>
> ```bash
> # 올바른 사용법 - agent-browser CLI
> agent-browser open "https://example.com" --profile zep-admin
> agent-browser snapshot -ic -d 3
> agent-browser find "text" "버튼" click
> agent-browser screenshot /tmp/qa-result.png
>
> # 잘못된 사용법 - 절대 사용 금지
> mcp__claude-in-chrome__navigate(...)  # ❌ 금지
> mcp__claude-in-chrome__read_page(...) # ❌ 금지
> ```
>
> 서브 에이전트에게 Task를 위임할 때도 이 규칙을 prompt에 명시하세요.

### 모드 1: Linear 이슈 기반 (`/qa ZEP-xxx`)

1. `mcp__linear__get_issue` + `mcp__linear__list_comments`로 PRD 읽기
2. 시나리오 탐색:
   - PRD 본문: `## 테스트 방법`, `## 테스트 시나리오`, `## QA`, `## 검증` 섹션
   - 코멘트: `## QA 시나리오` 태그 (이전 실행에서 기록된 것)
3. **시나리오 없으면** → PRD에서 도출
4. **사용자 확인** (AskUserQuestion 1회로 아래 3가지를 함께 질문):
   - 시나리오 검토/수정
   - **테스트 환경** (URL, 환경 종류)
   - **데이터 의존성** (필요 데이터, 준비 방법)
5. agent-browser로 검수 실행 (확정된 환경 URL + 프로필)
6. 결과 리포트 → Linear 코멘트에 시나리오 기록

## 사용자 확인 (시나리오 + 환경 + 데이터)

시나리오 도출 후, 검수 실행 전에 **한번에** 아래 내용을 사용자에게 제시하고 확인받는다.

```
## QA 시나리오
(도출된 시나리오 목록)

## 테스트 환경
- 검수 대상 URL을 알려주세요 (예: dev-xxx.zep.us, localhost:3000, xxx.zep.us)
- 로그인이 필요하면 사용할 프로필도 알려주세요

## 테스트 데이터

| 필요 데이터 | 용도 | 준비 방법 |
|------------|------|----------|
| [데이터명] | [시나리오에서 사용처] | [조회/생성/목업] |
```

### 환경 판단 규칙

- PRD만으로는 환경을 추정하지 않음. **반드시 사용자에게 물어본다**
- localhost → 프로필 없이 접근
- 프로필 목록에 없는 도메인 → 프로필 필요 여부 확인

### 데이터 분석 체크리스트

PRD에서 추출:

- **입력값**: 폼 필드, 업로드 파일, 선택 옵션
- **참조 데이터**: 다른 엔티티를 참조하는 ID, 외래키
- **선행 조건**: 특정 상태의 데이터, 권한, 설정

| 준비 전략 | 설명 |
|----------|------|
| 조회 | 기존 테스트 데이터 검색하여 사용 |
| 생성 | UI 또는 API로 새 데이터 생성 |
| 목업 | 검증/에러 케이스용 가짜 데이터 |

### 모드 2: URL 직접 (`/qa <URL>`)

URL 도메인으로 프로필 매칭 후 페이지 접근, snapshot, 에러 체크, 스크린샷 수행.

### 공통 규칙

- 세션 만료 감지: URL에 `sign-in`, `login`, `auth` 포함 시 `/qa-login` 안내
- localhost는 프로필 없이 접근

### 스크린샷 저장 규칙

이슈ID + 타임스탬프 폴더 생성, 파일명에도 이슈 번호 포함:

```
/tmp/qa/ZEP-183-20260220-173000/
├── ZEP-183-init.png
├── ZEP-183-6-1-button.png
├── ZEP-183-6-2-modal.png
├── ZEP-183-1-2-upload-valid.png
├── ZEP-183-2-3-wrong-format.png
├── ZEP-183-4-1-processing.png
├── ZEP-183-5-1-result.png
└── ...
```

파일명 패턴: `<이슈ID>-<시나리오번호>-<설명>.png`

```bash
QA_DIR="/tmp/qa/<이슈ID>-$(date +%Y%m%d-%H%M%S)"
mkdir -p "$QA_DIR"
agent-browser screenshot "$QA_DIR/<이슈ID>-init.png"
```

### 리포트 기록

검수 완료 후 `mcp__linear__create_comment`로 Playwright 스타일 리포트를 이슈에 기록.
형식은 [scenario-format.md](references/scenario-format.md) 참조.

## 레퍼런스

- **브라우저 명령어, 실행 패턴, 검증 필요 시**: [browser-automation.md](references/browser-automation.md)
- **Linear 기록 형식 필요 시**: [scenario-format.md](references/scenario-format.md)
