---
name: obsidian
description: 옵시디언 노트를 읽고, 검색하고, 작성하고, 정리합니다. 노트 찾기, 태그 검색, 링크 탐색, 학습 내용 정리, 인박스 정리, 지식 관리할 때 사용합니다.
---

# 옵시디언 노트 스킬

## 볼트 경로
`/Users/jinhoin/Library/Mobile Documents/com~apple~CloudDocs/Obsidian/Vault`

## 가이드

| 작업 | 참조 |
|---|---|
| 검색, 태그 찾기, 링크 탐색 | [READ.md](READ.md) |
| 노트 작성, 템플릿, GitHub 푸시 | [WRITE.md](WRITE.md) |
| 인박스 정리, 폴더 분류 | [ORGANIZE.md](ORGANIZE.md) |

## 폴더 구조 (PARA)
```
Vault/
├── 00-Inbox/       # 임시 노트, 빠른 캡처
├── 01-Projects/    # 명확한 목표/마감이 있는 프로젝트
├── 02-Areas/       # 지속적 관심 영역
├── 03-Resources/   # 참고 자료, 레퍼런스
├── 04-Archive/     # 완료/비활성
└── private/        # 비공개 (GitHub 제외, iCloud만)
```

## 핵심 규칙

- 노트 작성 전 공개(#public) / 비공개(#private) 반드시 확인
- 비공개 노트는 `private/` 폴더에 저장
- frontmatter의 위키링크는 반드시 리스트 + 따옴표 형식 사용
- 노트 작성/수정 후 반드시 GitHub 푸시
