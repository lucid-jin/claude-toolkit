# 옵시디언 노트 작성 가이드

## 볼트 경로
`/Users/jinhoin/Library/Mobile Documents/com~apple~CloudDocs/Obsidian/Vault`

---

## ⚠️ 필수: 공개 여부 확인

**노트 작성 전에 반드시 사용자에게 물어볼 것:**

> "이 노트를 공개용으로 할까요, 비공개로 할까요?"

| 선택 | 태그 | 저장 위치 | GitHub |
|------|------|----------|--------|
| 공개 | `#public` | `00-Inbox/` 등 일반 폴더 | ✅ 올라감 |
| 비공개 | `#private` | `private/` 폴더 | ❌ 안 올라감 (iCloud만) |

### 저장 경로
```
공개: /Users/jinhoin/Library/Mobile Documents/com~apple~CloudDocs/Obsidian/Vault/00-Inbox/노트.md
비공개: /Users/jinhoin/Library/Mobile Documents/com~apple~CloudDocs/Obsidian/Vault/private/노트.md
```

---

## 파일명 규칙

| 유형 | 형식 | 예시 |
|------|------|------|
| 학습 노트 | `YYYY-MM-DD-제목.md` | `2026-01-17-Claude-Skills.md` |
| 영구 노트 | `제목.md` | `React-Hooks.md` |
| 프로젝트 | `프로젝트명-항목.md` | `MyApp-설계.md` |

---

## ⚠️ frontmatter 주의사항

**YAML frontmatter 안에서 `[[]]` 위키링크를 직접 쓰면 안 됨.**
옵시디언이 `Invalid properties` 에러를 표시함.

```yaml
# ❌ 잘못된 예시
related: [[노트A]], [[노트B]]

# ✅ 올바른 예시 (리스트 + 따옴표)
related:
  - "[[노트A]]"
  - "[[노트B]]"

# ✅ 비어있을 때
related: []
```

이 규칙은 `related` 뿐 아니라 frontmatter 안의 모든 위키링크에 적용됨.

---

## 노트 템플릿

### 학습 노트
```markdown
---
created: YYYY-MM-DD
related:
  - "[[관련노트]]"
status: draft
---

#public 또는 #private  ← 공개 여부 (필수)
#분야태그 #유형태그

# 제목

## 핵심 요약
> 한 문장으로 핵심 정리

## 주요 내용
- 포인트 1
- 포인트 2
- [[관련개념]] 연결

## 나의 생각
- 이해한 것:
- 의문점:
- 적용 아이디어:

## 연결
- 관련 노트: [[노트1]], [[노트2]]
- 참고 자료:
```

---

## 태그 체계

### 해시태그 스타일 (프론트매터 아래에 작성)
```markdown
---
created: 2026-01-17
---

#programming #ai #howto
```

### 태그 분류
| 유형 | 예시 | 용도 |
|------|------|------|
| **공개** | #public #private | 공개 여부 (필수) |
| 분야 | #programming #ai #design | 큰 카테고리 |
| 상태 | #todo #learning #done | 진행 상태 |
| 유형 | #concept #howto #reference | 노트 유형 |

---

## 백링크 활용

### 기본
```markdown
[[노트명]]
```

### 특정 섹션 링크
```markdown
[[노트명#섹션]]
```

### 별칭 사용
```markdown
[[긴노트명|짧은표시]]
```

---

## 작성 원칙

### 학습 내용 정리 시
1. **핵심만 추출** - 3-5개 포인트로 압축
2. **나만의 언어로** - 복사 금지, 이해한 대로
3. **예시 포함** - 개념마다 구체적 예시
4. **연결 찾기** - 기존 노트와 링크

### Zettelkasten 방식
| 유형 | 설명 | 저장 위치 |
|------|------|----------|
| 순간 노트 | 빠른 아이디어 캡처 | 00-Inbox |
| 문헌 노트 | 읽은 내용 정리 | 03-Resources |
| 영구 노트 | 정제된 나만의 지식 | 02-Areas |

### 질문 프레임워크
노트 작성 시 이 질문들 고려:
- 이것은 무엇인가?
- 왜 중요한가?
- 어디에 적용할 수 있는가?
- 무엇과 연결되는가?

---

## 작업 체크리스트

- [ ] 기존에 비슷한 노트 있는지 검색
- [ ] 적절한 태그 부여
- [ ] 관련 노트에 백링크 연결
- [ ] "나의 생각" 섹션 작성
- [ ] **GitHub 동기화** (필수)

---

## GitHub 동기화 (필수)

노트 작성/수정 후 **반드시** GitHub에 푸시해야 함.

```bash
cd "/Users/jinhoin/Library/Mobile Documents/com~apple~CloudDocs/Obsidian/Vault"
git add .
git commit -m "docs: 노트 추가/수정 - 제목"
git push
```

### 왜 필수인가?
- iCloud = 기기 간 동기화
- GitHub = 버전 관리 + 백업 + 히스토리
