# Claude Toolkit

A collection of personal Claude plugins and skills for Claude Code and Claude.ai.

**[English](README.md) | [한국어](README.ko.md)**

## 📦 Included Skills

### 1. Obsidian (`/obsidian`)
Obsidian note management and automation skill

#### Features
- **READ**: Search notes, find tags, explore backlinks
- **WRITE**: Create notes, structure, organize content
- **ORGANIZE**: Manage inbox, classify folders, knowledge management

#### Included Guides
- `SKILL.md` - Skill introduction and core rules
- `READ.md` - Guide for reading and searching notes
- `WRITE.md` - Guide for creating notes
- `ORGANIZE.md` - Guide for organizing and classifying notes

#### Usage Examples

After installation, use in Claude Code:

```
/obsidian

Find all notes about "Claude" in my Obsidian vault
```

Or:

```
/obsidian

I have draft notes from 2026-01-17. Where should I classify them?
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

### ⚙️ Vault Path Configuration (Important!)

After installation, configure your Obsidian vault path:

```bash
# Edit these files to set your vault path:
~/.claude/skills/obsidian/SKILL.md
~/.claude/skills/obsidian/READ.md
~/.claude/skills/obsidian/WRITE.md
~/.claude/skills/obsidian/ORGANIZE.md
```

Change the vault path to match your setup:

**Default path (macOS):**
```
~/Library/Mobile Documents/com~apple~CloudDocs/Obsidian/Vault
```

**If using a different path:**
```bash
# Update to your vault path
~/Documents/My Vault
/Volumes/External/Obsidian
```

---

### Using with Claude.ai

Claude.ai doesn't support local plugin systems. Instead, you can:
- Reference the guide files (`READ.md`, `WRITE.md`, `ORGANIZE.md`) from this repository
- Set up as an MCP (Model Context Protocol) server for more powerful integration

## 📝 Project Structure

```
claude-toolkit/
├── .claude-plugin/
│   └── marketplace.json   # Plugin marketplace configuration
├── obsidian/
│   ├── SKILL.md          # Skill definition and metadata
│   ├── READ.md           # Reading and search guide
│   ├── WRITE.md          # Writing guide
│   └── ORGANIZE.md       # Organization and classification guide
├── .gitignore
├── README.md             # English version
└── README.ko.md          # Korean version
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
