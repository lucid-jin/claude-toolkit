# Claude Toolkit

Claude Code 스킬 & MCP 서버 모음.

**[English](README.en.md) | [한국어](README.md)**

---

## Skills

| 스킬 | 설명 |
|---|---|
| **obsidian** | 옵시디언 노트 관리 - 검색, 작성, 정리 |
| **skill-creator** | Anthropic 공식 스킬 생성 가이드 |
| **skill-publish** | 로컬 스킬 → GitHub 선택적 업로드 |
| **skill-pull** | GitHub → 로컬 스킬 선택적 다운로드 |

---

## 설치

### 부트스트랩: skill-pull 먼저 설치

`skill-pull`은 다른 스킬을 가져오는 부트스트랩 스킬입니다.
플러그인에 종속되지 않고, 수동으로 한 번만 설치하면 됩니다.

```bash
# 1. skill-pull 수동 설치 (최초 1회)
git clone https://github.com/lucid-jin/claude-toolkit.git /tmp/claude-toolkit
mkdir -p ~/.claude/skills/skill-pull
cp /tmp/claude-toolkit/skills/skill-pull/SKILL.md ~/.claude/skills/skill-pull/
rm -rf /tmp/claude-toolkit

# 2. Claude Code에서 나머지 스킬 가져오기
# "스킬 가져와" 또는 "skill pull" 이라고 말하면
# skill-pull이 트리거되어 원하는 스킬을 선택 설치할 수 있음
```

### 또는 전체 수동 설치

```bash
git clone https://github.com/lucid-jin/claude-toolkit.git
cp -r claude-toolkit/skills/* ~/.claude/skills/
```

---

## 스킬 관리 워크플로우

```
[로컬에서 스킬 생성/수정]
        │
        ▼
  skill-publish ──→ GitHub 레포에 선택적 업로드

[다른 PC에서]
        │
        ▼
  skill-pull ──→ GitHub에서 선택적 다운로드
```

- **skill-pull**: 부트스트랩. 어떤 PC에서든 이것만 설치하면 나머지를 가져올 수 있음
- **skill-publish**: 로컬에서 만든 스킬을 GitHub에 올릴 때 사용
- **skill-creator**: 새 스킬을 만들 때 Anthropic 공식 가이드 참고

---

## MCP Servers

Linear, Sentry 등 MCP 서버 설정.

```bash
cd mcp && ./setup.sh
```

자세한 내용: [mcp/README.md](mcp/README.md)

---

## 프로젝트 구조

```
claude-toolkit/
├── skills/
│   ├── obsidian/          # 옵시디언 노트 관리
│   ├── skill-creator/     # 스킬 생성 가이드
│   ├── skill-publish/     # 로컬 → GitHub 업로드
│   └── skill-pull/        # GitHub → 로컬 다운로드
├── mcp/
│   ├── .mcp.json          # MCP 서버 설정
│   └── setup.sh           # 설정 스크립트
├── .claude-plugin/
│   └── marketplace.json   # 플러그인 설정
└── README.md
```

---

MIT License
