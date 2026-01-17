# Obsidian Skill

옵시디언 노트를 읽고, 검색하고, 작성하고, 정리합니다. 노트 찾기, 태그 검색, 링크 탐색, 학습 내용 정리, 인박스 정리, 지식 관리할 때 사용합니다.

**Allowed Tools:** Read, Write, Edit, Glob, Grep, Bash(ls:*, mkdir:*, cat:*, find:*, mv:*)

## 🔧 Vault 경로 설정 (중요!)

### 설정 방법

**Step 1: Vault 경로 확인**

Obsidian에서 현재 vault 경로를 확인하세요:
- Obsidian 열기
- 좌측 하단 "vault 이름" 클릭
- "vault 폴더 열기" → 경로 복사

**Step 2: 스킬 파일 수정**

다음 4개 파일을 편집하여 경로를 변경하세요:

```bash
nano ~/.claude/skills/obsidian/README.md
nano ~/.claude/skills/obsidian/READ.md
nano ~/.claude/skills/obsidian/WRITE.md
nano ~/.claude/skills/obsidian/ORGANIZE.md
```

**Step 3: 경로 변경**

각 파일에서 기본 경로를 찾아 수정:

```
❌ Before:
~/Library/Mobile Documents/com~apple~CloudDocs/Obsidian/Vault

✅ After (your vault path):
/Users/username/Documents/My Vault
또는
~/Obsidian/MainVault
```

### 기본 경로들

| OS | 기본 경로 |
|---|---|
| **macOS** | `~/Library/Mobile Documents/com~apple~CloudDocs/Obsidian/Vault` |
| **Linux** | `~/.var/app/md.obsidian.Obsidian/data/Obsidian Vault` |
| **Windows** | `C:\Users\YourName\Documents\Obsidian Vault` |

### 설정 확인

설정 후 Claude Code에서:
```
/obsidian

내 vault에서 노트를 찾아줘
```

정상 작동하면 완료! ✅

## 📚 가이드

| 작업 | 가이드 |
|------|--------|
| 노트 검색, 태그 찾기, 링크 탐색 | [READ.md](READ.md) |
| 노트 작성, 구조화, 정리 | [WRITE.md](WRITE.md) |
| 인박스 정리, 폴더 분류, 지식 관리 | [ORGANIZE.md](ORGANIZE.md) |

## 📋 핵심 규칙

### 검색할 때
```bash
# 키워드 검색
Grep: pattern="키워드" path="~/Library/Mobile Documents/com~apple~CloudDocs/Obsidian/Vault"

# 태그 검색
Grep: pattern="#태그명" path="~/Library/Mobile Documents/com~apple~CloudDocs/Obsidian/Vault"
```

### 작성할 때
```markdown
---
created: YYYY-MM-DD
related: [[관련노트]]
status: draft
---

#태그1 #태그2

# 제목

## 핵심 요약
> 한 문장 정리

## 주요 내용
- 포인트

## 나의 생각
- 이해/의문/적용
```

## 📁 폴더 구조 (PARA)

```
~/Library/Mobile Documents/com~apple~CloudDocs/Obsidian/Vault/
├── 00-Inbox/      # 📥 임시 노트, 빠른 캡처
├── 01-Projects/   # 🎯 명확한 목표가 있는 프로젝트
├── 02-Areas/      # 🔄 지속적 관심 영역
├── 03-Resources/  # 📚 참고 자료, 레퍼런스
├── 04-Archive/    # 📦 완료되거나 비활성
└── private/       # 🔒 비공개 (GitHub 제외)
```

### 분류 기준

- **Projects**: 명확한 마감일/완료 기준이 있는 것
- **Areas**: 지속적으로 관리하고 발전시킬 영역
- **Resources**: 참고용 자료, 나중에 찾아볼 것
- **Archive**: 더 이상 활발히 사용하지 않는 것
- **private**: 절대 공개되면 안 되는 것

---

**사용 방법:**
1. 위의 가이드를 참고하세요
2. 각 작업에 맞는 가이드 문서를 확인하세요
3. Vault 경로를 자신의 환경에 맞게 수정한 후 사용하세요
