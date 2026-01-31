# Claude Toolkit

A collection of Claude Code skills & MCP servers.

**[English](README.en.md) | [한국어](README.md)**

---

## Skills

| Skill | Description |
|---|---|
| **obsidian** | Obsidian note management - search, create, organize |
| **skill-creator** | Anthropic official skill creation guide |
| **skill-publish** | Selectively upload local skills to GitHub |
| **skill-pull** | Selectively download skills from GitHub |

---

## Installation

### Bootstrap: Install skill-pull first

`skill-pull` is a bootstrap skill that fetches other skills.
It's independent of any plugin system - install it manually once.

```bash
# 1. Manual install skill-pull (one-time)
git clone https://github.com/lucid-jin/claude-toolkit.git /tmp/claude-toolkit
mkdir -p ~/.claude/skills/skill-pull
cp /tmp/claude-toolkit/skills/skill-pull/SKILL.md ~/.claude/skills/skill-pull/
rm -rf /tmp/claude-toolkit

# 2. Fetch remaining skills in Claude Code
# Say "pull skills" or "download skills"
# skill-pull will trigger and let you choose which skills to install
```

### Or full manual install

```bash
git clone https://github.com/lucid-jin/claude-toolkit.git
cp -r claude-toolkit/skills/* ~/.claude/skills/
```

---

## Skill Management Workflow

```
[Create/edit skill locally]
        |
        v
  skill-publish --> Selectively upload to GitHub

[On another PC]
        |
        v
  skill-pull --> Selectively download from GitHub
```

- **skill-pull**: Bootstrap. Install this on any PC to fetch the rest
- **skill-publish**: Upload locally created skills to GitHub
- **skill-creator**: Anthropic official guide for creating new skills

---

## MCP Servers

Linear, Sentry, and more.

```bash
cd mcp && ./setup.sh
```

Details: [mcp/README.md](mcp/README.md)

---

## Project Structure

```
claude-toolkit/
├── skills/
│   ├── obsidian/          # Obsidian note management
│   ├── skill-creator/     # Skill creation guide
│   ├── skill-publish/     # Local → GitHub upload
│   └── skill-pull/        # GitHub → Local download
├── mcp/
│   ├── .mcp.json          # MCP server config
│   └── setup.sh           # Setup script
├── .claude-plugin/
│   └── marketplace.json   # Plugin config
└── README.md
```

---

MIT License
