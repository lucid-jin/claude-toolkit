---
name: obsidian
description: 옵시디언 노트를 읽고, 검색하고, 작성하고, 정리합니다. 노트 찾기, 태그 검색, 링크 탐색, 학습 내용 정리, 인박스 정리, 지식 관리할 때 사용합니다.
allowed-tools: Read, Write, Edit, Glob, Grep, Bash(ls:*, mkdir:*, cat:*, find:*, mv:*)
---

# 옵시디언 노트 스킬

## 볼트 경로
`~/Library/Mobile Documents/com~apple~CloudDocs/Obsidian/Vault`

## 빠른 참조

| 작업 | 가이드 |
|------|--------|
| 노트 검색, 태그 찾기, 링크 탐색 | [READ.md](READ.md) |
| 노트 작성, 구조화, 정리 | [WRITE.md](WRITE.md) |
| 인박스 정리, 폴더 분류, 지식 관리 | [ORGANIZE.md](ORGANIZE.md) |

## 핵심 규칙

### 검색할 때
```bash
# 키워드 검색
Grep: pattern="키워드" path="~/Documents/Obsidian Vault"

# 태그 검색
Grep: pattern="#태그명" path="~/Documents/Obsidian Vault"
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

## 폴더 구조 (PARA)
```
~/Library/Mobile Documents/com~apple~CloudDocs/Obsidian/Vault/
├── 00-Inbox/      # 📥 임시 노트, 빠른 캡처
├── 01-Projects/   # 🎯 명확한 목표가 있는 프로젝트
├── 02-Areas/      # 🔄 지속적 관심 영역
├── 03-Resources/  # 📚 참고 자료, 레퍼런스
├── 04-Archive/    # 📦 완료되거나 비활성
└── private/       # 🔒 비공개 (GitHub 제외)
```

**분류 기준:**
- Projects: 명확한 마감일/완료 기준
- Areas: 지속적으로 관리하는 영역
- Resources: 참고용 자료
- Archive: 더 이상 활발히 사용 안 함
- private: 절대 공개 안 되는 것
