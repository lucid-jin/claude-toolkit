# 검색 가이드

볼트 경로: `/Users/jinhoin/Library/Mobile Documents/com~apple~CloudDocs/Obsidian/Vault`

## 검색 패턴

```bash
# 파일명으로 찾기
Glob: /Users/jinhoin/Library/Mobile Documents/com~apple~CloudDocs/Obsidian/Vault/**/*키워드*.md

# 내용에서 찾기
Grep: pattern="키워드" path="/Users/jinhoin/Library/Mobile Documents/com~apple~CloudDocs/Obsidian/Vault"

# 태그 검색
Grep: pattern="#태그명" path="/Users/jinhoin/Library/Mobile Documents/com~apple~CloudDocs/Obsidian/Vault"

# 백링크 탐색 (특정 노트를 참조하는 노트)
Grep: pattern="\[\[노트명\]\]" path="/Users/jinhoin/Library/Mobile Documents/com~apple~CloudDocs/Obsidian/Vault"

# 특정 폴더 내 노트 목록
Glob: /Users/jinhoin/Library/Mobile Documents/com~apple~CloudDocs/Obsidian/Vault/00-Inbox/*.md

# status별 검색
Grep: pattern="status: draft" path="/Users/jinhoin/Library/Mobile Documents/com~apple~CloudDocs/Obsidian/Vault"
```
