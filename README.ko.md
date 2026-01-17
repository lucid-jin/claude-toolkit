# Claude Toolkit

개인 Claude 플러그인 모음입니다. Claude Code와 Claude.ai에서 사용할 수 있는 다양한 스킬을 포함하고 있습니다.

**[English](README.md) | [한국어](README.ko.md)**

---

## 📦 스킬 & 도구

### 🎯 Obsidian 스킬
옵시디언 노트 관리 자동화 - 노트 검색, 작성, 정리

📖 **[전체 설정 & 가이드 →](skills/obsidian/README.md)**

**빠른 사용:**
```
/obsidian
내 vault에서 "Project"를 포함한 노트 찾아줘
```

---

### 🔌 MCP 서버 모음
개인용 MCP: **Linear**, **Sentry**, 그 외 등

🔧 **[빠른 설정 가이드 →](mcp/README.md)**

**초간단 한 번 설정:**
```bash
cd mcp && ./setup.sh    # 완료! ✨
```

---

## 🚀 설치

### ⭐ 방법 1: 플러그인 마켓플레이스 (추천)

```bash
/plugin marketplace add lucid-jin/claude-toolkit
/plugin install obsidian@lucid-jin-claude-toolkit
```

사용:
```bash
/obsidian
```

### 방법 2: 수동 설치

```bash
git clone https://github.com/lucid-jin/claude-toolkit.git
cp -r claude-toolkit/skills/obsidian ~/.claude/skills/obsidian
```

---

## 📋 먼저 할 일

1. **Obsidian 스킬?** → [📖 Obsidian 설정](skills/obsidian/README.md)
2. **MCP 서버?** → [🔧 MCP 설정](mcp/README.md)
3. **사용 방법?** → 각 가이드 참고

---

## 📁 프로젝트 구조

```
claude-toolkit/
├── .claude/
│   └── memory.md                    # 프로젝트 컨텍스트
├── .claude-plugin/
│   └── marketplace.json             # 플러그인 설정
├── skills/
│   └── obsidian/
│       ├── README.md                # 설정 & vault 경로
│       ├── READ.md                  # 검색 가이드
│       ├── WRITE.md                 # 작성 가이드
│       └── ORGANIZE.md              # 정리 가이드
├── mcp/
│   ├── .mcp.json                    # MCP 서버 설정
│   ├── setup.sh                     # 대화형 설정
│   └── README.md                    # MCP 가이드
└── README.md                        # 이 파일
```

---

## 📚 더 알아보기

- [Obsidian 공식](https://obsidian.md/)
- [Claude Code 문서](https://claude.com/claude-code)
- [Linear](https://linear.app/)
- [Sentry](https://sentry.io/)

---

## 📄 라이선스

MIT License

---

**도움이 필요하신가요?** 각 스킬이나 MCP 서버의 가이드를 참고하세요.
