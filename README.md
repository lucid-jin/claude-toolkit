# Claude Toolkit

개인 Claude 플러그인 모음입니다. Claude Code와 Claude.ai에서 사용할 수 있는 다양한 스킬을 포함하고 있습니다.

## 📦 포함된 스킬

### 1. Obsidian (`/obsidian`)
옵시디언(Obsidian) 노트 관리 자동화 스킬

#### 기능
- **READ**: 노트 검색, 태그 찾기, 백링크 탐색
- **WRITE**: 노트 작성, 구조화, 정리
- **ORGANIZE**: 인박스 정리, 폴더 분류, 지식 관리

#### 포함된 가이드
- `SKILL.md` - 스킬 소개 및 핵심 규칙
- `READ.md` - 노트 읽기/검색 가이드
- `WRITE.md` - 노트 작성 가이드
- `ORGANIZE.md` - 인박스 정리 및 분류 가이드

#### 사용 예시

설치 후 Claude Code에서:

```
/obsidian

내 옵시디언 vault에서 "Claude"에 대한 노트를 모두 찾아줘
```

또는:

```
/obsidian

2026-01-17에 작성한 draft 노트들을 정리해야 하는데 어디로 분류하면 좋을까?
```

## 🚀 설치 방법

### Claude Code에서 사용하기

1. **레포 클론 또는 다운로드**
   ```bash
   git clone https://github.com/lucid-jin/claude-toolkit.git
   ```

2. **스킬 폴더를 Claude 스킬 디렉토리에 복사**
   ```bash
   cp -r claude-toolkit/obsidian ~/.claude/skills/obsidian
   ```

3. **Claude Code에서 스킬 사용**
   ```
   /obsidian
   ```
   위 명령으로 스킬을 호출할 수 있습니다.

### 경로 설정 (중요!)

스킬의 가이드 파일에 있는 vault 경로를 자신의 환경에 맞게 수정하세요:

```bash
# obsidian 스킬 가이드 파일들을 열어서 다음 경로를 확인/수정
~/.claude/skills/obsidian/SKILL.md
~/.claude/skills/obsidian/READ.md
~/.claude/skills/obsidian/WRITE.md
~/.claude/skills/obsidian/ORGANIZE.md

# 기본 경로: ~/Library/Mobile Documents/com~apple~CloudDocs/Obsidian/Vault
# 본인 경로로 변경해야 정상 작동합니다
```

### Claude.ai에서 사용하기

Claude.ai는 로컬 스킬 시스템을 지원하지 않습니다. 대신:
- 이 레포의 스킬 가이드 파일들을 참고하여 수동으로 지시사항을 작성하여 사용할 수 있습니다.
- 또는 MCP(Model Context Protocol) 서버로 설정할 수 있습니다.

## 📝 스킬 구조

```
claude-toolkit/
├── obsidian/
│   ├── SKILL.md          # 스킬 정의 및 메타데이터
│   ├── READ.md           # 읽기/검색 가이드
│   ├── WRITE.md          # 작성 가이드
│   └── ORGANIZE.md       # 정리 가이드
└── README.md
```

## 🔧 커스터마이징

각 스킬은 모듈식으로 설계되어 있어 필요에 따라 수정할 수 있습니다:

1. 스킬 메타데이터 수정 (SKILL.md의 frontmatter)
2. 경로 업데이트 (vault 위치 등)
3. 규칙 커스터마이징 (필요시)

## 📚 더 알아보기

- [Obsidian 공식 사이트](https://obsidian.md/)
- [Claude Code 문서](https://claude.com/claude-code)

## 📄 라이선스

MIT License

## 🤝 기여

개인 도구이지만 개선 사항이나 버그 리포트는 환영합니다!

---

**마지막 업데이트**: 2026-01-17
