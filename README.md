# Claude Toolkit

개인 Claude 플러그인 모음입니다. Claude Code와 Claude.ai에서 사용할 수 있는 다양한 스킬을 포함하고 있습니다.

## 📦 포함된 스킬

### 1. Obsidian (`/obsidian`)
옵시디언(Obsidian) 노트 관리 자동화 스킬

#### 기능
- **READ**: 노트 검색, 태그 찾기, 백링크 탐색
- **WRITE**: 노트 작성, 구조화, 정리
- **ORGANIZE**: 인박스 정리, 폴더 분류, 지식 관리

#### 사용 방법
1. Claude에서 `/obsidian` 스킬 로드
2. 스킬의 마크다운 가이드 참고:
   - `SKILL.md` - 스킬 소개 및 핵심 규칙
   - `READ.md` - 노트 읽기/검색 가이드
   - `WRITE.md` - 노트 작성 가이드
   - `ORGANIZE.md` - 인박스 정리 가이드

#### Vault 경로 설정
기본 경로: `~/Library/Mobile Documents/com~apple~CloudDocs/Obsidian/Vault`

다른 경로를 사용 중이라면 각 가이드 파일의 경로를 수정하세요.

## 🚀 설치

### Claude Code에서
```bash
git clone https://github.com/lucid-jin/claude-toolkit.git
cd claude-toolkit
```

### Claude.ai에서
이 레포의 스킬 파일들을 참고하여 설정합니다.

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
