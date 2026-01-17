# Claude Toolkit

개인 Claude 플러그인 모음입니다. Claude Code와 Claude.ai에서 사용할 수 있는 다양한 스킬을 포함하고 있습니다.

**[English](README.md) | [한국어](README.ko.md)**

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

### ⭐ 방법 1: 플러그인 마켓플레이스 (추천)

Claude Code에서 다음 커맨드를 실행합니다:

```bash
/plugin marketplace add lucid-jin/claude-toolkit
```

그 다음 플러그인을 설치합니다:

```bash
/plugin install obsidian@lucid-jin-claude-toolkit
```

설치 완료! 이제 아래와 같이 사용할 수 있습니다:

```
/obsidian

내 옵시디언 vault에서 "Claude"에 대한 노트를 모두 찾아줘
```

**장점:**
- 한 줄의 명령어로 설치 완료
- 자동 업데이트 지원
- 여러 플러그인 쉽게 관리

---

### 방법 2: 수동 설치 (클래식)

1. **레포 클론**
   ```bash
   git clone https://github.com/lucid-jin/claude-toolkit.git
   ```

2. **스킬 폴더를 Claude 디렉토리에 복사**
   ```bash
   cp -r claude-toolkit/obsidian ~/.claude/skills/obsidian
   ```

3. **Claude Code에서 사용**
   ```
   /obsidian
   ```

---

### ⚙️ Vault 경로 설정 (중요!)

설치 후 자신의 Obsidian vault 경로를 설정해야 합니다:

```bash
# 설정할 파일들 (아래 경로들 중 하나 또는 모두)
~/.claude/skills/obsidian/SKILL.md
~/.claude/skills/obsidian/READ.md
~/.claude/skills/obsidian/WRITE.md
~/.claude/skills/obsidian/ORGANIZE.md
```

각 파일에서 다음 경로를 **본인의 vault 경로로 변경**하세요:

**기본 경로 (macOS):**
```
~/Library/Mobile Documents/com~apple~CloudDocs/Obsidian/Vault
```

**다른 경로 사용 중이라면:**
```bash
# 본인의 vault 경로로 변경
~/Documents/My Vault
/Volumes/External/Obsidian
```

---

### Claude.ai에서 사용하기

Claude.ai는 로컬 플러그인 시스템을 지원하지 않습니다. 대신:
- 이 레포의 가이드 파일들(`READ.md`, `WRITE.md`, `ORGANIZE.md`)을 참고하여 사용할 수 있습니다
- MCP(Model Context Protocol) 서버로 확장하면 더 강력한 통합이 가능합니다

## 📝 프로젝트 구조

```
claude-toolkit/
├── .claude-plugin/
│   └── marketplace.json   # 플러그인 마켓플레이스 설정
├── obsidian/
│   ├── SKILL.md          # 스킬 정의 및 메타데이터
│   ├── READ.md           # 읽기/검색 가이드
│   ├── WRITE.md          # 작성 가이드
│   └── ORGANIZE.md       # 정리 가이드
├── .gitignore
├── README.md             # English version
└── README.ko.md          # 한국어 버전
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
