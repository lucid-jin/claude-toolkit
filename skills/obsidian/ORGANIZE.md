# 인박스 정리 가이드

볼트 경로: `/Users/jinhoin/Library/Mobile Documents/com~apple~CloudDocs/Obsidian/Vault`

## 정리 프로세스

1. `00-Inbox/*.md` 노트 나열
2. 각 노트의 frontmatter(status, 태그) 확인
3. `status: complete`인 노트만 분류 대상 (draft는 인박스 유지)
4. 아래 기준으로 이동 폴더 결정
5. 사용자에게 제안 후 확인 받고 이동
6. GitHub 커밋/푸시

## 분류 기준

| 폴더 | 기준 |
|---|---|
| `01-Projects/` | 명확한 마감일/완료 기준이 있음 |
| `02-Areas/` | 지속적으로 관리/발전시킬 영역 |
| `03-Resources/` | 참고용 자료, 나중에 찾아볼 것 |
| `04-Archive/` | 더 이상 활발히 사용 안 함 |
| `private/` | 절대 공개 불가 |

## 태그 기반 자동 분류

| 태그 | 폴더 |
|---|---|
| `#project` | `01-Projects/` |
| `#learning` `#concept` `#howto` | `02-Areas/` |
| `#reference` | `03-Resources/` |
| `#done` `#archived` | `04-Archive/` |
| `#private` | `private/` |

## 이동 시 주의

- 폴더 없으면 `mkdir -p`로 생성
- 이동 후 백링크 깨지지 않았는지 확인
- 정리 후 GitHub 커밋 (공개 노트만)
