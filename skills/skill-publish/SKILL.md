---
name: skill-publish
description: 로컬 스킬을 GitHub claude-toolkit 레포에 선택적으로 업로드합니다. 새로 만든 스킬을 GitHub에 올리고 싶을 때, 어떤 스킬이 변경됐는지 확인하고 싶을 때, 특정 스킬만 골라서 푸시하고 싶을 때 사용합니다.
---

# 스킬 퍼블리시

## 경로

- 로컬 스킬: `~/.claude/skills/`
- GitHub 레포: `https://github.com/lucid-jin/claude-toolkit`
- 레포 로컬 (옵셔널): `~/WebstormProjects/claude-toolkit`

## 퍼블리시 프로세스

### 1. 로컬 스킬 목록 확인

```bash
ls ~/.claude/skills/
```

### 2. 레포 준비

```bash
LOCAL_REPO="$HOME/WebstormProjects/claude-toolkit"

if [ -d "$LOCAL_REPO/.git" ]; then
  REPO_DIR="$LOCAL_REPO"
  cd "$REPO_DIR" && git pull
else
  REPO_DIR=$(mktemp -d)
  git clone https://github.com/lucid-jin/claude-toolkit.git "$REPO_DIR"
fi
```

### 3. 비교 및 사용자에게 보여주기

각 로컬 스킬에 대해 상태 판단:

| 상태 | 의미 |
|---|---|
| **NEW** | 레포에 없는 새 스킬 |
| **MODIFIED** | 레포에 있지만 내용이 다름 |
| **UP-TO-DATE** | 레포와 동일 |

비교 방법:
```bash
# 로컬 스킬 목록
LOCAL_SKILLS=$(ls ~/.claude/skills/)

# 각 스킬별 상태 확인
for skill in $LOCAL_SKILLS; do
  if [ ! -d "$REPO_DIR/skills/$skill" ]; then
    echo "$skill: NEW"
  elif ! diff -rq ~/.claude/skills/$skill "$REPO_DIR/skills/$skill" > /dev/null 2>&1; then
    echo "$skill: MODIFIED"
  else
    echo "$skill: UP-TO-DATE"
  fi
done
```

결과를 표로 정리해서 사용자에게 보여주기.

### 4. 사용자에게 선택 받기

AskUserQuestion 도구로 어떤 스킬을 올릴지 확인.
UP-TO-DATE인 스킬은 선택지에서 제외.

### 5. 선택한 스킬만 복사

```bash
# 선택된 스킬만 복사
rsync -av ~/.claude/skills/선택한스킬/ "$REPO_DIR/skills/선택한스킬/"
```

### 6. marketplace.json 업데이트

새 스킬이면 `.claude-plugin/marketplace.json`의 plugins 배열에 추가:

```json
{
  "name": "스킬명",
  "source": "./스킬명",
  "description": "SKILL.md의 description에서 가져옴"
}
```

### 7. 변경사항 확인 후 커밋 & 푸시

```bash
cd "$REPO_DIR"
git diff --stat
# 사용자 확인 후
git add skills/선택한스킬/ .claude-plugin/marketplace.json
git commit -m "feat: 스킬명 스킬 추가/업데이트"
git push
```

### 8. 임시 클론 정리

레포가 임시 클론이었으면 삭제.

## 주의사항

- 퍼블리시 전 반드시 변경사항을 사용자에게 보여주고 확인 받을 것
- 새 스킬은 marketplace.json에도 등록
- SKILL.md의 frontmatter에 `name`과 `description`이 있는지 검증
