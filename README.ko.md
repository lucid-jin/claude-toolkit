# Claude Toolkit

개인 Claude 플러그인 모음입니다. Claude Code와 Claude.ai에서 사용할 수 있는 다양한 스킬을 포함하고 있습니다.

**[English](README.md) | [한국어](README.ko.md)**

## 📦 포함된 스킬

### 1. Obsidian 스킬
옵시디언 노트 관리 자동화 - 노트 검색, 작성, 정리

**기능:** 노트 검색, 태그 찾기, 백링크 탐색, 구조화된 노트 작성, 인박스 관리, 폴더 분류

📖 **[Obsidian 스킬 문서 →](obsidian/README.md)**

#### 빠른 예시

설치 후 Claude Code에서:

```
/obsidian

내 옵시디언 vault에서 "Project"를 포함한 모든 노트를 찾아줘
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

### ⚙️ Vault 경로 설정

설치 후 스킬 파일들에서 본인의 Obsidian vault 경로를 업데이트하세요:

```bash
~/.claude/skills/obsidian/README.md
~/.claude/skills/obsidian/READ.md
~/.claude/skills/obsidian/WRITE.md
~/.claude/skills/obsidian/ORGANIZE.md
```

기본 경로를 자신의 vault 위치에 맞게 수정하세요. 자세한 내용은 [Obsidian 스킬 문서](obsidian/README.md)를 참고하세요.

---

### Claude.ai에서 사용하기

Claude.ai는 로컬 플러그인 시스템을 지원하지 않습니다. 대신:
- 이 레포의 가이드 파일들(`READ.md`, `WRITE.md`, `ORGANIZE.md`)을 참고하여 사용할 수 있습니다
- MCP(Model Context Protocol) 서버로 확장하면 더 강력한 통합이 가능합니다

## 📝 프로젝트 구조

```
claude-toolkit/
├── .claude-plugin/
│   └── marketplace.json        # 플러그인 마켓플레이스 설정
├── obsidian/
│   ├── README.md              # Obsidian 스킬 문서
│   ├── READ.md                # 읽기/검색 가이드
│   ├── WRITE.md               # 작성 가이드
│   └── ORGANIZE.md            # 정리 및 분류 가이드
├── .gitignore
├── README.md                   # English version (메인)
└── README.ko.md               # 한국어 버전
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
