# 작성 가이드

볼트 경로: `/Users/jinhoin/Library/Mobile Documents/com~apple~CloudDocs/Obsidian/Vault`

## 공개 여부 (필수)

노트 작성 전 반드시 사용자에게 확인할 것.

| 선택 | 태그 | 저장 위치 | GitHub |
|---|---|---|---|
| 공개 | `#public` | 일반 폴더 | 올라감 |
| 비공개 | `#private` | `private/` | 안 올라감 |

## 파일명 규칙

- 학습 노트: `YYYY-MM-DD-제목.md`
- 영구 노트: `제목.md`
- 프로젝트: `프로젝트명-항목.md`

## frontmatter 주의사항

YAML frontmatter 안에서 `[[]]` 위키링크를 직접 쓰면 `Invalid properties` 에러 발생.

```yaml
# ❌ 잘못됨
related: [[노트A]], [[노트B]]

# ✅ 올바름
related:
  - "[[노트A]]"
  - "[[노트B]]"

# ✅ 비어있을 때
related: []
```

## 노트 템플릿

```markdown
---
created: YYYY-MM-DD
related:
  - "[[관련노트]]"
status: draft
---

#public #분야태그

# 제목

## 핵심 요약
> 한 문장 정리

## 주요 내용
- 포인트

## 나의 생각
- 이해/의문/적용
```

## 태그 분류

| 유형 | 예시 |
|---|---|
| 공개 여부 (필수) | `#public` `#private` |
| 분야 | `#programming` `#ai` `#design` |
| 상태 | `#todo` `#learning` `#done` |
| 유형 | `#concept` `#howto` `#reference` |

## GitHub 동기화 (필수)

노트 작성/수정 후 반드시 실행:

```bash
cd "/Users/jinhoin/Library/Mobile Documents/com~apple~CloudDocs/Obsidian/Vault"
git add .
git commit -m "docs: 노트 추가/수정 - 제목"
git push
```
