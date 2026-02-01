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

## /qa-login

headed 브라우저를 열어 사용자가 직접 로그인. 세션이 프로필에 자동 저장됨.

```bash
agent-browser open <login-url> --profile <name> --headed
# 사용자 로그인 완료 후
agent-browser close
```

## /qa

**반드시 Task tool (run_in_background=true)로 실행.** 메인 세션 블로킹 금지.

### 모드 1: Linear 이슈 기반 (`/qa ZEP-xxx`)

1. `mcp__linear__get_issue` + `mcp__linear__list_comments`로 PRD 읽기
2. 시나리오 탐색:
   - PRD 본문: `## 테스트 방법`, `## 테스트 시나리오`, `## QA`, `## 검증` 섹션
   - 코멘트: `## QA 시나리오` 태그 (이전 실행에서 기록된 것)
3. **시나리오 있으면** → 바로 실행
4. **시나리오 없으면** → PRD에서 도출 → 사용자 확인(AskUserQuestion) → 실행 → Linear 코멘트에 기록
5. agent-browser로 검수 실행 (프로필 자동 매칭)
6. 결과 리포트

시나리오 코멘트 기록 형식: [references/scenario-format.md](references/scenario-format.md)

### 모드 2: URL 직접 (`/qa <URL>`)

URL 도메인으로 프로필 매칭 후 페이지 접근, snapshot, 에러 체크, 스크린샷 수행.

### 공통 규칙

- 세션 만료 감지: URL에 `sign-in`, `login`, `auth` 포함 시 `/qa-login` 안내
- 스크린샷 저장: `/tmp/qa-<이슈ID|timestamp>.png`
- localhost는 프로필 없이 접근
