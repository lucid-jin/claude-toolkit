# Claude Toolkit Project Memory

## Project Overview
Personal Claude plugins and skills collection. Includes automation tools for Obsidian note management.

## Folder Structure

```
claude-toolkit/
├── .claude/
│   └── memory.md                    # This file - project context
├── .claude-plugin/
│   └── marketplace.json             # Plugin marketplace configuration
├── skills/
│   └── obsidian/
│       ├── README.md                # Obsidian skill main documentation
│       ├── READ.md                  # Guide: Reading and searching notes
│       ├── WRITE.md                 # Guide: Writing structured notes
│       └── ORGANIZE.md              # Guide: Organizing and classifying notes
├── .gitignore
├── README.md                        # English documentation (main)
├── README.ko.md                     # Korean documentation
└── package.json (optional - for future)
```

## Key Files

### Root Level
- **README.md**: Main English documentation with installation and overview
- **README.ko.md**: Korean version of README
- **.claude-plugin/marketplace.json**: Plugin marketplace metadata defining available skills

### Skills
Each skill lives in `skills/{skill-name}/`

#### obsidian/ - Obsidian Note Management Skill
- **README.md**: Skill overview, features, and core rules
- **READ.md**: Guide for searching notes by keyword, tag, or backlink
- **WRITE.md**: Guide for creating structured notes with frontmatter
- **ORGANIZE.md**: Guide for organizing inbox using PARA method

## Installation Methods

1. **Plugin Marketplace** (Recommended)
   ```bash
   /plugin marketplace add lucid-jin/claude-toolkit
   /plugin install obsidian@lucid-jin-claude-toolkit
   ```

2. **Manual Installation**
   ```bash
   git clone https://github.com/lucid-jin/claude-toolkit.git
   cp -r claude-toolkit/skills/obsidian ~/.claude/skills/obsidian
   ```

## Vault Path Configuration

Default: `~/Library/Mobile Documents/com~apple~CloudDocs/Obsidian/Vault`

Must be updated in:
- `skills/obsidian/README.md`
- `skills/obsidian/READ.md`
- `skills/obsidian/WRITE.md`
- `skills/obsidian/ORGANIZE.md`

## Skills Information

### Obsidian Skill
- **Type**: Note management automation
- **Features**: Search, create, organize notes with Claude
- **Allowed Tools**: Read, Write, Edit, Glob, Grep, Bash (ls, mkdir, cat, find, mv)
- **Usage**: `/obsidian` command in Claude Code

## MCP Servers Configuration

### One-Time Setup (Global)
```bash
# 프로젝트의 mcp 폴더에서 한 번만 실행
./mcp/setup.sh

# 스크립트가 자동으로:
# 1. ~/.claude/.env 생성 (전역 환경변수 저장)
# 2. ~/.zshrc에 source 명령 추가
# 3. 이후 모든 터미널 세션에서 자동 로드
```

### After Setup
```bash
# 터미널 재시작
source ~/.zshrc

# 환경변수 확인
echo $LINEAR_API_KEY
echo $SENTRY_API_KEY

# Claude Code 시작
claude

# /mcp 명령으로 MCP 서버 상태 확인
```

### Included MCP Servers
- **Linear** (https://linear.app/settings/api)
- **Sentry** (https://sentry.io/settings/account/api/)

### Updating API Keys
```bash
# API 키를 변경하려면 다시 실행
./mcp/setup.sh

# 또는 직접 수정
nano ~/.claude/.env
```

### Key Files
- **Setup Script**: `mcp/setup.sh` - Interactive API key configuration
- **Environment File**: `~/.claude/.env` - Global MCP environment variables (auto-created)
- **Config**: `mcp/.mcp.json` - MCP server definitions

## Future Expansion

Skills should be added under `skills/` folder:
```
skills/
├── obsidian/
├── [new-skill-1]/
└── [new-skill-2]/
```

Each skill should follow same structure:
- `README.md` - Main documentation
- Additional guides as needed
- Listed in `.claude-plugin/marketplace.json`

## Repository
- **GitHub**: https://github.com/lucid-jin/claude-toolkit
- **Languages**: English (main), Korean
- **License**: MIT

---

**Last Updated**: 2026-01-17
