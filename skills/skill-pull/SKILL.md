---
name: skill-pull
description: GitHub claude-toolkit 레포에서 스킬을 선택적으로 로컬에 다운로드합니다. 다른 PC에서 스킬을 가져오고 싶을 때, 특정 스킬만 골라서 설치하고 싶을 때, 로컬 스킬을 최신 상태로 업데이트하고 싶을 때 사용합니다.
---

# 스킬 풀

## 경로

- 로컬 스킬: `~/.claude/skills/`
- GitHub 레포: `https://github.com/lucid-jin/claude-toolkit`
- 레포 로컬 (옵셔널): `~/WebstormProjects/claude-toolkit`

## 풀 프로세스

### 1. 레포 준비

```bash
LOCAL_REPO="$HOME/WebstormProjects/claude-toolkit"

if [ -d "$LOCAL_REPO/.git" ]; then
  REPO_DIR="$LOCAL_REPO"
  cd "$REPO_DIR" && git pull
else
  REPO_DIR=$(mktemp -d)
  git clone https://github.com/lucid-jin/claude-toolkit.git "$REPO_DIR"
  TEMP_CLONE=true
fi
```

### 2. 레포 스킬 목록 확인 및 비교

각 레포 스킬에 대해 상태 판단:

| 상태 | 의미 |
|---|---|
| **NEW** | 로컬에 없는 스킬 |
| **UPDATED** | 로컬에 있지만 레포가 더 최신 |
| **UP-TO-DATE** | 로컬과 동일 |

비교 방법:
```bash
REPO_SKILLS=$(ls "$REPO_DIR/skills/")

for skill in $REPO_SKILLS; do
  if [ ! -d "$HOME/.claude/skills/$skill" ]; then
    echo "$skill: NEW"
  elif ! diff -rq "$REPO_DIR/skills/$skill" "$HOME/.claude/skills/$skill" > /dev/null 2>&1; then
    echo "$skill: UPDATED"
  else
    echo "$skill: UP-TO-DATE"
  fi
done
```

결과를 표로 정리해서 사용자에게 보여주기.

### 3. 사용자에게 선택 받기

AskUserQuestion 도구로 어떤 스킬을 설치/업데이트할지 확인.
UP-TO-DATE인 스킬은 선택지에서 제외.

### 4. 선택한 스킬만 복사

```bash
mkdir -p ~/.claude/skills/
rsync -av "$REPO_DIR/skills/선택한스킬/" ~/.claude/skills/선택한스킬/
```

### 5. 임시 클론 정리

레포가 임시 클론이었으면 삭제.

## 주의사항

- 로컬에 수정한 스킬이 있으면 덮어쓰기 전 사용자에게 경고
- SKILL.md가 없는 폴더는 스킬로 취급하지 않음
