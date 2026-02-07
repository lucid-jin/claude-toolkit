---
name: review-pr
description: PR 적대적 코드리뷰 에이전트. /review-pr 123 으로 GitHub PR을 4명의 에이전트(버그헌터, 품질검사관, 변호사, 심판)가 병렬로 리뷰. /review-pr 만 입력하면 현재 브랜치의 PR 자동 감지. /review-pr https://github.com/org/repo/pull/123 으로 외부 PR도 가능. PR 리뷰, 코드리뷰, 코드 검수할 때 사용.
user-invocable-skills:
  - review-pr: Run adversarial code review on a GitHub PR
---

# PR 적대적 코드리뷰

4명의 에이전트가 서로 다른 관점으로 PR을 동시에 리뷰하고, 심판이 종합 판정.

## 실행

```
/review-pr 123                                    # PR 번호 (현재 repo)
/review-pr                                        # 현재 브랜치 PR 자동 감지
/review-pr https://github.com/org/repo/pull/123   # 외부 repo PR URL
```

## 워크플로우

### 1. PR 정보 수집

```bash
# URL이면 repo와 번호를 파싱
# 번호만 있으면 현재 repo 사용
# 인자 없으면 현재 브랜치에서 자동 감지

gh pr view <PR번호> --repo <repo> --json number,title,body,headRefName,baseRefName
gh pr diff <PR번호> --repo <repo>
gh pr diff <PR번호> --repo <repo> --name-only
```

### 2. 맥락 수집

변경된 파일마다:
- 파일 전체 읽기 (diff만으로는 맥락 부족)
- import/require 중 핵심 의존성 1~2개 읽기
- 관련 테스트 파일 읽기
- 프로젝트 루트의 CLAUDE.md 읽기 (있으면)

파일이 20개 넘으면 변경량 큰 파일 위주로 10개 선별.

### 3. 에이전트 병렬 실행

Task tool로 버그헌터, 품질검사관, 변호사 3명을 **동시에** 실행 (run_in_background=true, model=sonnet).

에이전트 프롬프트는 [references/agents.md](references/agents.md) 참조.

각 에이전트에게 전달할 컨텍스트:
```
- PR 제목 + 설명 (body)
- diff 전체
- 변경 파일 전체 소스 (외부 repo면 diff만)
- 주변 의존성 파일 (핵심만)
- CLAUDE.md 내용 (있으면)
```

프롬프트 끝에 반드시 추가: `DO NOT read any files. All context is in this prompt. Just analyze and return findings.`

### 4. 결과 종합

3명 결과를 모아서 심판 에이전트에게 전달. 심판은 **동기 실행** (run_in_background=false).

### 5. 출력 형식

사용자에게 보여줄 최종 결과:

```markdown
## PR #123 리뷰 결과

### Must Fix (반드시 수정)
- [파일:라인] 이슈 설명 — 근거

### Should Fix (권장 수정)
| # | 이슈 | 파일 | 설명 |

### Dismissed (기각)
- 항목 — 기각 사유

### 종합 의견
머지 가능 여부 한 문단
```

### 6. PR 코멘트 (선택)

사용자가 요청하면 `gh pr comment`로 리뷰 결과를 PR에 게시. 추론 과정은 `<details>` 접기로 포함.
