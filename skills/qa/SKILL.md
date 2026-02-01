---
name: qa
description: QA 검수 에이전트. Linear 이슈의 PRD를 기반으로 테스트 시나리오를 도출하고 agent-browser로 자동 검수합니다. /qa <이슈번호|URL> 로 실행, /qa-login <profile> 으로 세션 등록.
allowed-tools: Bash(agent-browser:*), Task, mcp__linear__get_issue, mcp__linear__list_comments, mcp__linear__create_comment
user-invocable-skills:
  - qa: Run QA check based on Linear PRD or URL
  - qa-login: Open headed browser to register/refresh a login session profile
---

# QA 검수 에이전트

Linear PRD 기반으로 테스트 시나리오를 도출하고, 브라우저 프로필을 사용해 자동 검수하는 에이전트입니다.

## 프로필 목록

| 프로필명 | 서비스 | URL 패턴 | 비고 |
|---------|--------|----------|------|
| zep-admin | ZEP 어드민 | admin.zep.us | NextAuth 세션 |

> 프로필 추가 시 이 테이블을 업데이트하세요.

---

## /qa-login 사용법

브라우저 프로필을 등록하거나 만료된 세션을 갱신합니다.

### 호출 형식

```
/qa-login <profile-name> <login-url>
```

### 예시

```
/qa-login zep-admin https://admin.zep.us
```

### 동작

1. `agent-browser open <login-url> --profile <profile-name> --headed` 로 브라우저를 엽니다
2. 사용자에게 **직접 로그인**하라고 안내합니다
3. 사용자가 로그인 완료를 알리면 `agent-browser close` 로 브라우저를 닫습니다
4. 프로필이 자동 저장됩니다 (`--profile` 옵션이 쿠키/스토리지를 자동 보관)

### 세션 만료 확인

프로필로 페이지를 열었을 때 URL에 `sign-in`, `login`, `auth`가 포함되면 세션이 만료된 것입니다.
이 경우 사용자에게 `/qa-login`으로 재로그인하라고 안내하세요.

---

## /qa 사용법

### 호출 형식

두 가지 방식으로 호출할 수 있습니다:

```
/qa <Linear이슈ID>          # PRD 기반 검수 (권장)
/qa <URL>                    # URL 직접 검수 (기존 방식)
```

### 예시

```
/qa ZEP-181                  # Linear PRD 기반 시나리오 자동 도출 → 검수
/qa https://admin.zep.us/space   # URL 직접 검수
```

---

## 모드 1: Linear 이슈 기반 검수 (`/qa ZEP-xxx`)

**반드시 백그라운드 서브 에이전트(Task tool, run_in_background=true)로 실행**하여 메인 세션을 블로킹하지 않습니다.

### 실행 흐름

#### Step 1. Linear에서 PRD 읽기

```
mcp__linear__get_issue(이슈ID)
```

PRD 본문과 코멘트를 읽어옵니다.

#### Step 2. 테스트 시나리오 확인

PRD 또는 코멘트에서 **기존 QA 시나리오**를 탐색합니다.

탐색 기준:
- PRD 본문에 `## 테스트 방법`, `## 테스트 시나리오`, `## QA`, `## 검증` 섹션이 있는지
- 코멘트에 `## QA 시나리오` 태그가 있는지 (이전 /qa 실행으로 기록된 것)

#### Step 3-A. 시나리오가 있는 경우

PRD/코멘트의 시나리오를 파싱하여 바로 실행합니다.

#### Step 3-B. 시나리오가 없는 경우

PRD의 요구사항에서 시나리오를 자동 도출합니다:

1. PRD의 **배경**, **작업 내용**, **구현 상세**, **완료 조건** 등을 분석
2. 브라우저로 검증 가능한 시나리오를 도출
3. 도출한 시나리오를 **사용자에게 보여주고 확인**받기 (AskUserQuestion)
4. 확인 후 실행
5. 확인된 시나리오를 **Linear 이슈 코멘트에 기록** (다음 실행 시 재사용)

코멘트 기록 형식:
```markdown
## QA 시나리오 (자동 생성)

### 시나리오 1: [제목]
- **URL**: [검수 대상 URL]
- **프로필**: [사용할 프로필]
- **단계**:
  1. [URL]에 접속
  2. [요소]를 클릭/입력
  3. [기대 결과] 확인
- **기대 결과**: [성공 조건]

### 시나리오 2: [제목]
...
```

#### Step 4. 시나리오 실행

각 시나리오에 대해 agent-browser로 검수를 수행합니다:

```bash
# 프로필 자동 매칭 (URL 도메인 기반)
agent-browser open <url> --profile <profile>

# 페이지 로드 대기
agent-browser wait --load networkidle

# 접근성 트리로 구조 확인
agent-browser snapshot -ic

# 시나리오 단계 실행 (클릭, 입력, 네비게이션 등)
agent-browser click @ref
agent-browser fill @ref "값"
agent-browser wait --text "기대 텍스트"

# 콘솔/에러 확인
agent-browser errors
agent-browser console

# 스크린샷
agent-browser screenshot --full /tmp/qa-<이슈ID>-<timestamp>.png

# 종료
agent-browser close
```

#### Step 5. 결과 리포트

메인 세션에 결과를 리포트합니다.

```markdown
## QA 검수 결과

**이슈**: ZEP-181 - Phase 4 himeji-data HyperDX 마이그레이션
**시간**: 2026-02-01 23:00

### 시나리오 결과
| # | 시나리오 | 결과 | 비고 |
|---|---------|------|------|
| 1 | 대시보드 페이지 로드 | ✅ 통과 | |
| 2 | 히메지 데이터 테이블 표시 | ✅ 통과 | 30행 정상 |
| 3 | 검색 기능 동작 | ❌ 실패 | 결과 0건 반환 |

### 실패 상세
#### 시나리오 3: 검색 기능 동작
- **기대**: 검색 결과가 1건 이상
- **실제**: 빈 테이블
- **스크린샷**: /tmp/qa-ZEP-181-scenario3.png

### 전체 스크린샷
/tmp/qa-ZEP-181-20260201-2300.png
```

---

## 모드 2: URL 직접 검수 (`/qa <URL>`)

Linear 이슈 없이 URL을 직접 검수합니다. **반드시 백그라운드 서브 에이전트(Task tool, run_in_background=true)로 실행**.

### 프로필 자동 매칭

| URL 패턴 | 프로필 |
|----------|--------|
| admin.zep.us | zep-admin |
| localhost* | (프로필 없이 접근) |

### 검수 항목

1. **페이지 접근 확인**: 로그인 리다이렉트 여부
2. **페이지 구조 확인**: snapshot으로 주요 UI 요소 렌더링 확인
3. **콘솔 에러 확인**: JS 에러, 네트워크 에러
4. **스크린샷 캡처**: `/tmp/qa-<timestamp>.png`

### 결과 리포트 형식

```markdown
## QA 검수 결과

**URL**: https://admin.zep.us/space
**프로필**: zep-admin
**시간**: 2026-02-01 22:50

### 체크 결과
- ✅ 페이지 접근: 정상
- ✅ UI 렌더링: 테이블 30행 표시
- ⚠️ 콘솔 경고: 2건
- ❌ JS 에러: 1건 (TypeError: Cannot read property...)

### 스크린샷
/tmp/qa-20260201-2250.png
```
