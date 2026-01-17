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
