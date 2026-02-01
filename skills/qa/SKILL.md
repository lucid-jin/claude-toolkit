---
name: qa
description: QA 검수 에이전트. 저장된 브라우저 프로필을 사용해 웹 페이지를 자동 검수합니다. /qa <url> 로 백그라운드에서 검수를 실행하고, /qa-login <profile> 으로 세션을 등록합니다.
allowed-tools: Bash(agent-browser:*), Task
user-invocable-skills:
  - qa: Run QA check on a URL using saved browser profile
  - qa-login: Open headed browser to register/refresh a login session profile
---

# QA 검수 에이전트

브라우저 프로필 기반으로 인증된 페이지를 자동 검수하는 에이전트입니다.

## 프로필 목록

| 프로필명 | 서비스 | URL | 비고 |
|---------|--------|-----|------|
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

저장된 프로필로 페이지를 열고 자동 검수합니다. **반드시 백그라운드 서브 에이전트(Task tool, run_in_background=true)로 실행**하여 메인 세션을 블로킹하지 않습니다.

### 호출 형식

```
/qa <url> [--profile <name>] [--checks <항목>]
```

- `--profile`: 사용할 프로필 (기본값: URL 도메인에서 자동 매칭)
- `--checks`: 검수 항목 (기본값: all)

### 예시

```
/qa https://admin.zep.us/space
/qa https://admin.zep.us/dashboard --checks ui,console
/qa http://localhost:3000/admin
```

### 프로필 자동 매칭

| URL 패턴 | 프로필 |
|----------|--------|
| admin.zep.us | zep-admin |
| localhost* | (프로필 없이 접근) |

### 검수 항목

서브 에이전트는 다음을 순서대로 수행합니다:

#### 1. 페이지 접근 확인
```bash
agent-browser open <url> --profile <profile>
```
- URL이 로그인 페이지로 리다이렉트되는지 확인
- 리다이렉트 시 "세션 만료, /qa-login 으로 재로그인 필요" 리포트

#### 2. 페이지 구조 확인 (snapshot)
```bash
agent-browser snapshot -ic
```
- 주요 UI 요소가 렌더링되었는지 확인
- 빈 테이블, 빈 리스트 등 데이터 누락 감지

#### 3. 콘솔 에러 확인
```bash
agent-browser errors
agent-browser console
```
- JavaScript 에러 유무
- 네트워크 에러 유무

#### 4. 스크린샷 캡처
```bash
agent-browser screenshot --full /tmp/qa-<timestamp>.png
```

#### 5. 브라우저 종료
```bash
agent-browser close
```

### 결과 리포트 형식

```
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
