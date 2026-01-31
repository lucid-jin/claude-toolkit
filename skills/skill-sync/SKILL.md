---
name: skill-sync
description: 로컬 Claude 스킬(~/.claude/skills/)을 GitHub claude-toolkit 레포에 동기화합니다. 스킬을 수정한 후 GitHub에 반영하고 싶을 때, 다른 PC에서 스킬을 복원하고 싶을 때, 스킬 변경사항을 확인하고 싶을 때 사용합니다.
---

# 스킬 동기화

## 설정

- 로컬 스킬: `~/.claude/skills/`
- GitHub: `https://github.com/lucid-jin/claude-toolkit`
- 로컬 레포 (옵셔널): `~/WebstormProjects/claude-toolkit`

## 동기화 (로컬 → GitHub)

### 1. 레포 준비

로컬 레포가 있으면 사용, 없으면 임시 클론:

```bash
LOCAL_REPO="$HOME/WebstormProjects/claude-toolkit"

if [ -d "$LOCAL_REPO/.git" ]; then
  REPO_DIR="$LOCAL_REPO"
  TEMP_CLONE=false
else
  REPO_DIR=$(mktemp -d)
  git clone https://github.com/lucid-jin/claude-toolkit.git "$REPO_DIR"
  TEMP_CLONE=true
fi
```

### 2. 원격 변경사항 먼저 가져오기

```bash
cd "$REPO_DIR" && git pull
```

### 3. 스킬 파일 복사

```bash
rsync -av --delete ~/.claude/skills/ "$REPO_DIR/skills/"
```

### 4. 변경사항 확인

```bash
cd "$REPO_DIR" && git diff --stat
```

변경사항이 없으면 "변경사항 없음"을 알리고 종료.
변경사항이 있으면 사용자에게 보여주고 확인 받기.

### 5. 커밋 & 푸시

커밋 메시지에 변경된 스킬 이름 포함:

```bash
git add skills/
git commit -m "chore: 스킬 동기화 - 변경된 스킬 목록"
git push
```

### 6. 정리

임시 클론이었으면 삭제:

```bash
if [ "$TEMP_CLONE" = true ]; then rm -rf "$REPO_DIR"; fi
```

## 복원 (GitHub → 로컬)

```bash
LOCAL_REPO="$HOME/WebstormProjects/claude-toolkit"

if [ -d "$LOCAL_REPO/.git" ]; then
  cd "$LOCAL_REPO" && git pull
  rsync -av "$LOCAL_REPO/skills/" ~/.claude/skills/
else
  REPO_DIR=$(mktemp -d)
  git clone https://github.com/lucid-jin/claude-toolkit.git "$REPO_DIR"
  rsync -av "$REPO_DIR/skills/" ~/.claude/skills/
  rm -rf "$REPO_DIR"
fi
```

## 주의사항

- 동기화 전 반드시 `git pull`로 원격 최신 상태 확인
- 푸시 전 `git diff`로 변경사항을 사용자에게 보여주고 확인 받을 것
- 변경사항 없으면 커밋하지 않음
