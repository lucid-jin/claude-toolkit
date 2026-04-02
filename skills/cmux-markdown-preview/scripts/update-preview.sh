#!/usr/bin/env bash
set -euo pipefail

# === Config ===
MD_FILE="${1:?Usage: update-preview.sh <file.md>}"

# === Resolve absolute path ===
MD_FILE="$(cd "$(dirname "$MD_FILE")" && pwd)/$(basename "$MD_FILE")"

# === Generate unique paths per file ===
FILE_HASH=$(echo -n "$MD_FILE" | md5 -q 2>/dev/null || echo -n "$MD_FILE" | md5sum | cut -d' ' -f1)
FILE_ID="${FILE_HASH:0:8}"
HTML_FILE="/tmp/cmux-md-preview-${FILE_ID}.html"
SERVE_DIR="/tmp/cmux-md-preview-serve-${FILE_ID}"

if [[ ! -f "$MD_FILE" ]]; then
  echo "Error: File not found: $MD_FILE" >&2
  exit 1
fi

# === Ensure markdown module ===
if ! python3 -c "import markdown" 2>/dev/null; then
  pip3 install markdown --quiet --break-system-packages 2>/dev/null || pip3 install markdown --quiet
fi

# === Generate HTML ===
FILENAME="$(basename "$MD_FILE")"

python3 -c "
import markdown
import sys

with open(sys.argv[1], 'r', encoding='utf-8') as f:
    content = f.read()

md = markdown.Markdown(extensions=[
    'tables', 'fenced_code', 'codehilite', 'toc', 'nl2br', 'sane_lists'
])
html_body = md.convert(content)

html = '''<!DOCTYPE html>
<html lang=\"ko\">
<head>
<meta charset=\"utf-8\">
<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">
<meta http-equiv=\"refresh\" content=\"2\">
<title>Preview: $FILENAME</title>
<style>
  :root {
    --bg: #ffffff; --fg: #24292f; --border: #d0d7de;
    --code-bg: #f6f8fa; --banner-bg: #f6f8fa; --banner-fg: #57606a;
    --link: #0969da; --blockquote-border: #d0d7de; --blockquote-fg: #57606a;
    --table-border: #d0d7de; --table-stripe: #f6f8fa;
  }
  @media (prefers-color-scheme: dark) {
    :root {
      --bg: #0d1117; --fg: #e6edf3; --border: #30363d;
      --code-bg: #161b22; --banner-bg: #161b22; --banner-fg: #8b949e;
      --link: #58a6ff; --blockquote-border: #30363d; --blockquote-fg: #8b949e;
      --table-border: #30363d; --table-stripe: #161b22;
    }
  }
  * { box-sizing: border-box; margin: 0; padding: 0; }
  body { font-family: -apple-system, BlinkMacSystemFont, \"Segoe UI\", \"Noto Sans\", Helvetica, Arial, sans-serif; font-size: 16px; line-height: 1.6; color: var(--fg); background: var(--bg); }
  .preview-banner { position: sticky; top: 0; z-index: 100; background: var(--banner-bg); border-bottom: 1px solid var(--border); padding: 8px 24px; font-size: 13px; color: var(--banner-fg); display: flex; align-items: center; gap: 8px; }
  .preview-banner .dot { width: 8px; height: 8px; background: #3fb950; border-radius: 50%; display: inline-block; }
  .content { max-width: 880px; margin: 0 auto; padding: 32px 24px; }
  h1, h2, h3, h4, h5, h6 { margin-top: 24px; margin-bottom: 16px; font-weight: 600; line-height: 1.25; }
  h1 { font-size: 2em; padding-bottom: 0.3em; border-bottom: 1px solid var(--border); }
  h2 { font-size: 1.5em; padding-bottom: 0.3em; border-bottom: 1px solid var(--border); }
  h3 { font-size: 1.25em; }
  p { margin-bottom: 16px; }
  a { color: var(--link); text-decoration: none; }
  a:hover { text-decoration: underline; }
  code { background: var(--code-bg); padding: 0.2em 0.4em; border-radius: 6px; font-size: 85%; font-family: ui-monospace, SFMono-Regular, \"SF Mono\", Menlo, Consolas, monospace; }
  pre { background: var(--code-bg); padding: 16px; border-radius: 6px; overflow-x: auto; margin-bottom: 16px; line-height: 1.45; }
  pre code { background: none; padding: 0; font-size: 85%; }
  blockquote { border-left: 4px solid var(--blockquote-border); color: var(--blockquote-fg); padding: 0 16px; margin-bottom: 16px; }
  ul, ol { padding-left: 2em; margin-bottom: 16px; }
  li + li { margin-top: 4px; }
  table { border-collapse: collapse; width: 100%; margin-bottom: 16px; }
  th, td { border: 1px solid var(--table-border); padding: 6px 13px; }
  th { font-weight: 600; }
  tr:nth-child(even) { background: var(--table-stripe); }
  hr { border: none; border-top: 1px solid var(--border); margin: 24px 0; }
  img { max-width: 100%; }
  .codehilite { background: var(--code-bg); padding: 16px; border-radius: 6px; overflow-x: auto; margin-bottom: 16px; }
</style>
</head>
<body>
<div class=\"preview-banner\">
  <span class=\"dot\"></span>
  Preview: $FILENAME
</div>
<div class=\"content\">
''' + html_body + '''
</div>
</body>
</html>'''

with open(sys.argv[2], 'w', encoding='utf-8') as f:
    f.write(html)
" "$MD_FILE" "$HTML_FILE"

mkdir -p "$SERVE_DIR"
cp "$HTML_FILE" "$SERVE_DIR/index.html"
echo "Preview updated: $MD_FILE"
