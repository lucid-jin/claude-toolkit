# 작성 가이드

볼트 경로: `/Users/jinhoin/Library/Mobile Documents/iCloud~md~obsidian/Documents/Vault`

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
cd "/Users/jinhoin/Library/Mobile Documents/iCloud~md~obsidian/Documents/Vault"
git add .
git commit -m "docs: 노트 추가/수정 - 제목"
git pull --rebase
git push
```

**주의**: `git push` 가 `(rejected - fetch first)` 로 실패하면 **에러가 아니라 정상 상황**. 원격에 최신 커밋이 있는 것뿐. `git pull --rebase` 후 다시 `git push` 하면 해결. 스킬이 자동으로 처리할 것.

---

## 세션/생각 덤프 워크플로우

사용자가 "인박스에 넣어줘", "오늘 대화 덤프", "생각 정리해서 저장", "데일리 정리" 등을 말하면 이 워크플로우를 **원샷으로** 실행한다. 사용자에게 추가 질문 없이 바로 진행 (단, 공개 여부만 확인 — 기본값 `#public`).

### Step 1: 현재 대화/맥락에서 추출

현재 세션의 내용에서 다음을 추출:

- **주제** → 파일명에 쓸 짧은 제목 (5~10단어)
- **오늘 뭘 알게 됐나** → 학습 내용, 새로 안 사실
- **나의 생각/직감** → 사용자가 직접 말한 통찰
- **결정한 것** → 이 세션에서 내린 결론 (표로)
- **미결정** → 아직 안 풀린 질문 (체크박스로)
- **가장 중요한 깨달음** → 한 줄 인용구로
- **다음 액션** → 1주일 뒤 본인이 할 일 (체크박스로)
- **참고 링크** → 대화에서 언급된 URL
- **메타 노트** → 세션 자체에 대한 반성 (길이, 패턴, 주의점)

### Step 2: 파일명

```
00-Inbox/YYYY-MM-DD-짧은-제목.md
```

- 한글 OK
- 공백은 하이픈
- 특수문자 제거
- 10단어 이내

### Step 3: frontmatter + 템플릿

```markdown
---
created: YYYY-MM-DD
related: []
status: draft
source: "Claude 세션 (N시간 대화)"  # 또는 해당 출처
---

#public #주제-태그 #inbox

# [제목]

## 핵심 요약
> 한 문장 정리

## 오늘 뭘 알게 됐나
- [주요 학습 내용]

## 내가 떠올린 직감/생각
- [통찰 1]
- [통찰 2]

## 결정한 것들

| 결정 | 이유 |
|---|---|
| [결정1] | [이유1] |

## 여전히 미결정
- [ ] [열린 질문 1]
- [ ] [열린 질문 2]

## 오늘 가장 중요한 깨달음
> **"[한 문장]"**

## 나의 생각 — 다음 액션
- [ ] 1주일 뒤 재검토, 가치 있으면 02-Areas/ 또는 03-Resources/ 승격
- [ ] 아니면 04-Archive/ 이동
- [ ] [구체 액션]

## 참고 링크
- [출처]

## 메타 노트
[세션 자체에 대한 반성 — 길이, 패턴, 다음엔 주의할 점]

---

*status: draft. 주간 정리 때 처리할 것.*
```

### Step 4: 저장 + 커밋 + 푸시 (원샷 자동)

```bash
cd "/Users/jinhoin/Library/Mobile Documents/iCloud~md~obsidian/Documents/Vault"
# 파일은 이미 Write 툴로 저장된 상태
git add "00-Inbox/파일명.md"
git commit -m "inbox: [제목]"
git pull --rebase
git push
```

`git push` 가 rejected면 `git pull --rebase` 후 재시도 (이미 위 순서에 포함).

### Step 5: 사용자에게 보고

짧게:
- 저장 경로
- 커밋 해시
- 1주일 뒤 재검토 안내

**긴 설명 금지**. 원샷 워크플로우의 핵심은 **마찰 없음**.

### 태그 선택 가이드

주제 태그는 대화 내용 기반으로 자동 선택:
- 프로그래밍: `#programming` `#frontend` `#backend`
- AI: `#ai` `#llm` `#claude-code` `#karpathy` 등
- 도구: `#obsidian` `#mcp` `#cursor`
- 지식관리: `#knowledge-management` `#para` `#zettelkasten`
- 의사결정: `#decision` `#retro` `#journal`
- 기본: `#public` + `#inbox` 항상 포함

비공개 신호가 있으면 (`회사`, `연봉`, `개인사` 등) `#private`로 하고 `private/` 에 저장.
