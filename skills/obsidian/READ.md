# 옵시디언 노트 읽기/검색 가이드

## 볼트 경로
`~/Library/Mobile Documents/com~apple~CloudDocs/Obsidian/Vault`

---

## 키워드로 노트 검색

### 파일명으로 찾기
```bash
Glob: ~/Library/Mobile Documents/com~apple~CloudDocs/Obsidian/Vault/**/*키워드*.md
```

### 내용에서 찾기
```bash
Grep: pattern="키워드" path="~/Library/Mobile Documents/com~apple~CloudDocs/Obsidian/Vault"
```

### 여러 키워드 (OR 검색)
```bash
Grep: pattern="React|Vue|Angular" path="~/Library/Mobile Documents/com~apple~CloudDocs/Obsidian/Vault"
```

---

## 태그로 노트 찾기

### 특정 태그
```bash
Grep: pattern="#programming" path="~/Library/Mobile Documents/com~apple~CloudDocs/Obsidian/Vault"
```

### 여러 태그 중 하나
```bash
Grep: pattern="#ai|#ml|#deeplearning" path="~/Library/Mobile Documents/com~apple~CloudDocs/Obsidian/Vault"
```

---

## 백링크 탐색

### 특정 노트를 참조하는 노트 찾기
```bash
Grep: pattern="\[\[노트명\]\]" path="~/Library/Mobile Documents/com~apple~CloudDocs/Obsidian/Vault"
```

### 예시: Claude Code 참조하는 노트
```bash
Grep: pattern="\[\[Claude Code\]\]" path="~/Library/Mobile Documents/com~apple~CloudDocs/Obsidian/Vault"
```

---

## 최근/목록 조회

### 최근 수정된 노트
```bash
ls -lt ~/Documents/Obsidian\ Vault/**/*.md | head -10
```

### 특정 폴더 내 노트 목록
```bash
Glob: ~/Library/Mobile Documents/com~apple~CloudDocs/Obsidian/Vault/00-Inbox/*.md
```

### 전체 노트 목록
```bash
Glob: ~/Library/Mobile Documents/com~apple~CloudDocs/Obsidian/Vault/**/*.md
```

---

## 고급 검색

### 프론트매터에서 특정 status 찾기
```bash
Grep: pattern="status: draft" path="~/Library/Mobile Documents/com~apple~CloudDocs/Obsidian/Vault"
```

### 특정 날짜에 생성된 노트
```bash
Grep: pattern="created: 2026-01-17" path="~/Library/Mobile Documents/com~apple~CloudDocs/Obsidian/Vault"
```

### 비어있는 섹션 찾기 (정리 필요한 노트)
```bash
Grep: pattern="## 나의 생각\n-$" path="~/Library/Mobile Documents/com~apple~CloudDocs/Obsidian/Vault"
```
