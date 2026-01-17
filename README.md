# Claude Toolkit

A collection of personal Claude plugins and skills for Claude Code and Claude.ai.

**[English](README.md) | [한국어](README.ko.md)**

---

## 📦 Skills & Tools

### 🎯 Obsidian Skill
Obsidian note management and automation - search, create, and organize your notes.

📖 **[Full Setup & Guide →](skills/obsidian/README.md)**

**Quick start:**
```
/obsidian
Find all notes about "Project" in my Obsidian vault
```

---

### 🔌 MCP Servers Collection
Personal MCP collection: **Linear**, **Sentry**, and more

🔧 **[Quick Setup Guide →](mcp/README.md)**

**Ultra-simple one-time setup:**
```bash
cd mcp && ./setup.sh    # Done! ✨
```

---

## 🚀 Installation

### ⭐ Method 1: Plugin Marketplace (Recommended)

```bash
/plugin marketplace add lucid-jin/claude-toolkit
/plugin install obsidian@lucid-jin-claude-toolkit
```

Then use:
```bash
/obsidian
```

### Method 2: Manual Installation

```bash
git clone https://github.com/lucid-jin/claude-toolkit.git
cp -r claude-toolkit/skills/obsidian ~/.claude/skills/obsidian
```

---

## 📋 What to Do First?

1. **Obsidian Skill?** → [📖 Obsidian Setup](skills/obsidian/README.md)
2. **MCP Servers?** → [🔧 MCP Setup](mcp/README.md)
3. **How to use?** → See individual guides above

---

## 📁 Project Structure

```
claude-toolkit/
├── .claude/
│   └── memory.md                    # Project context
├── .claude-plugin/
│   └── marketplace.json             # Plugin config
├── skills/
│   └── obsidian/
│       ├── README.md                # Setup & vault path
│       ├── READ.md                  # Search guide
│       ├── WRITE.md                 # Writing guide
│       └── ORGANIZE.md              # Organization guide
├── mcp/
│   ├── .mcp.json                    # MCP server config
│   ├── setup.sh                     # Interactive setup
│   └── README.md                    # MCP guide
└── README.md                        # This file
```

---

## 📚 Learn More

- [Obsidian Official](https://obsidian.md/)
- [Claude Code Docs](https://claude.com/claude-code)
- [Linear](https://linear.app/)
- [Sentry](https://sentry.io/)

---

## 📄 License

MIT License

---

**Need help?** Check the individual guides for each skill or MCP server.
