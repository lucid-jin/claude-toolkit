# Claude Toolkit

A collection of personal Claude plugins and skills for Claude Code and Claude.ai.

**[English](README.md) | [한국어](README.ko.md)**

## 📦 Included Skills

### 1. Obsidian Skill
Obsidian note management and automation - search, create, and organize your notes.

**Features:** Search notes, find tags, explore backlinks, create structured notes, manage inbox, classify folders

📖 **[Obsidian Skill Documentation →](skills/obsidian/README.md)**

#### Quick Example

After installation:

```
/obsidian

Find all notes about "Project" in my Obsidian vault
```

## 🔌 Included MCP Servers

Personal MCP collection: **Linear**, **Sentry**, and more

🔧 **[MCP Setup Guide →](mcp/README.md)**

**Quick Start:**
```bash
cd mcp
./setup.sh        # Interactive setup
source .env       # Load environment variables
claude            # Start Claude Code
```

## 🚀 Installation

### ⭐ Method 1: Plugin Marketplace (Recommended)

Run this command in Claude Code:

```bash
/plugin marketplace add lucid-jin/claude-toolkit
```

Then install the plugin:

```bash
/plugin install obsidian@lucid-jin-claude-toolkit
```

Done! Now you can use it like this:

```
/obsidian

Find all notes about "Project" in my Obsidian vault
```

**Benefits:**
- One-line installation
- Automatic updates
- Easy to manage multiple plugins

---

### Method 2: Manual Installation (Classic)

1. **Clone the repository**
   ```bash
   git clone https://github.com/lucid-jin/claude-toolkit.git
   ```

2. **Copy skill folder to Claude directory**
   ```bash
   cp -r claude-toolkit/obsidian ~/.claude/skills/obsidian
   ```

3. **Use in Claude Code**
   ```
   /obsidian
   ```

---

### ⚙️ Vault Path Configuration

After installation, update your Obsidian vault path in the skill files:

```bash
~/.claude/skills/obsidian/README.md
~/.claude/skills/obsidian/READ.md
~/.claude/skills/obsidian/WRITE.md
~/.claude/skills/obsidian/ORGANIZE.md
```

Update the default path to match your vault location. See [Obsidian Skill Documentation](skills/obsidian/README.md) for more details.

## 📝 Project Structure

```
claude-toolkit/
├── .claude/
│   └── memory.md                    # Project context for Claude Code
├── .claude-plugin/
│   └── marketplace.json             # Plugin marketplace configuration
├── skills/
│   └── obsidian/
│       ├── README.md                # Obsidian skill documentation
│       ├── READ.md                  # Reading and search guide
│       ├── WRITE.md                 # Writing guide
│       └── ORGANIZE.md              # Organization guide
├── mcp/
│   ├── .mcp.json                    # MCP servers configuration
│   ├── .env.example                 # Environment variables template
│   └── README.md                    # MCP setup guide
├── .gitignore
├── README.md                         # English version (main)
└── README.ko.md                     # Korean version
```

## 🔧 Customization

Each skill is modularly designed and can be modified as needed:

1. Edit skill metadata (frontmatter in SKILL.md)
2. Update paths (vault location, etc.)
3. Customize rules as needed

## 📚 Learn More

- [Obsidian Official Website](https://obsidian.md/)
- [Claude Code Documentation](https://claude.com/claude-code)

## 📄 License

MIT License

## 🤝 Contributing

While this is a personal tool, improvements and bug reports are welcome!

---

**Last Updated**: 2026-01-17
