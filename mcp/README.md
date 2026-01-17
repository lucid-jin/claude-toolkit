# MCP Servers Collection

개인적으로 자주 사용하는 MCP 서버들을 모아놓은 컬렉션입니다.

## 📦 포함된 MCP 서버

- **Linear** - 프로젝트 관리, 이슈 추적
- **Sentry** - 에러 모니터링, 성능 분석

## 🚀 설치

### 방법 1: 플러그인 마켓플레이스 (추천)

Claude Code에서:

```bash
/plugin marketplace add lucid-jin/claude-toolkit
/plugin install mcp-collection@lucid-jin-claude-toolkit
```

### 방법 2: 수동 설정

```bash
# 프로젝트 폴더에서
cp mcp/.mcp.json ~/.claude/.mcp.json
cp mcp/.env.example .env

# .env 파일에 API 키 입력
```

---

## ⚡ 초간단 설정 (한 번만!)

### 왜 이렇게 쉬울까?

| 항목 | 설정 전 ❌ | 설정 후 ✅ |
|------|----------|----------|
| **셋업** | 매번 env 파일 복사 | 한 번만 실행 |
| **환경변수** | 매번 source 입력 | 자동 로드 |
| **어디서나** | 특정 폴더에서만 | 모든 폴더에서 가능 |
| **유지관리** | 프로젝트마다 설정 | 전역에서 관리 |

### 💥 설정 (정말 쉬움!)

```bash
./mcp/setup.sh
```

**바로 끝! 스크립트가 모든 것을 자동으로:**
1. 🎯 API 키를 대화형으로 입력받음 (안내 포함)
2. 💾 `~/.claude/.env`에 저장 (전역 위치)
3. 🔗 `~/.zshrc`에 자동 로드 설정 추가
4. 🚀 이제 모든 터미널에서 자동으로 로드됨!

### 한 번 설정 후 (영구적!)

```bash
source ~/.zshrc        # 한 번만 리로드

# 이제 forever...
claude                 # 그냥 실행하면 끝!
# ↳ MCP 자동 로드됨 ✅
```

**매번 설정할 필요 없음 = 행복함** 😊

---

## 🔑 API 키 변경하기

API 키를 변경해야 한다면:

```bash
# 다시 실행하면 기존 키를 덮어씀
./mcp/setup.sh
```

또는 수동으로:
```bash
nano ~/.claude/.env
```

---

## 📋 API 키 획득 방법

### Linear

1. https://linear.app/settings/api 접속
2. **Create API key** 클릭
3. 키 복사 후 `.env`에 붙여넣기

```
LINEAR_API_KEY=lin_pat_xxxxxxxxxxxxx
```

### Sentry

1. https://sentry.io/settings/account/api/ 접속
2. **Create New Token** 클릭
3. `organization:read`, `organization:write` 권한 선택
4. 토큰 복사 후 `.env`에 붙여넣기

```
SENTRY_API_KEY=sntrys_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
```

---

## 💡 사용 예시

### Linear MCP 사용

Claude Code에서:

```
내 Linear의 진행 중인 이슈들을 보여줘
```

### Sentry MCP 사용

```
최근 에러를 정리해줘
```

---

## 🔐 보안

- `.env` 파일은 절대 GitHub에 올리지 않습니다 (`.gitignore`에 등록됨)
- API 키는 로컬에서만 보관됩니다
- 공개 저장소에서는 `.env.example` 파일만 공유됩니다

---

## 📝 구조

```
mcp/
├── .mcp.json              # MCP 서버 정의
├── .env.example           # 환경변수 템플릿
└── README.md              # 이 파일
```

---

## 🔄 새로운 MCP 추가하기

1. `.mcp.json`에 새 MCP 서버 추가
2. `.env.example`에 필요한 환경변수 추가
3. 이 README에 설명 추가
4. Git 커밋

예시:

```json
{
  "mcpServers": {
    "new-service": {
      "type": "http",
      "url": "https://api.service.com/mcp",
      "headers": {
        "Authorization": "Bearer ${NEW_SERVICE_API_KEY}"
      }
    }
  }
}
```

---

## 📚 참고

- [Claude Code MCP 문서](https://claude.com/claude-code)
- [Linear API](https://linear.app/api-reference)
- [Sentry API](https://docs.sentry.io/api/)

