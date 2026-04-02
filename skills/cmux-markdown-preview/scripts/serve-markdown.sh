#!/usr/bin/env bash
set -euo pipefail

# === Config ===
MD_FILE="${1:?Usage: serve-markdown.sh <file.md> [port]}"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# === Resolve absolute path ===
MD_FILE="$(cd "$(dirname "$MD_FILE")" && pwd)/$(basename "$MD_FILE")"

# === Generate unique port & paths per file ===
FILE_HASH=$(echo -n "$MD_FILE" | md5 -q 2>/dev/null || echo -n "$MD_FILE" | md5sum | cut -d' ' -f1)
FILE_ID="${FILE_HASH:0:8}"
PORT="${2:-$((18000 + (16#${FILE_ID} % 1000)))}"
PID_FILE="/tmp/cmux-md-preview-${FILE_ID}.pid"
HTML_FILE="/tmp/cmux-md-preview-${FILE_ID}.html"
SERVE_DIR="/tmp/cmux-md-preview-serve-${FILE_ID}"

if [[ ! -f "$MD_FILE" ]]; then
  echo "Error: File not found: $MD_FILE" >&2
  exit 1
fi

# === Ensure python3 markdown module ===
if ! python3 -c "import markdown" 2>/dev/null; then
  echo "Installing python markdown module..."
  pip3 install markdown --quiet --break-system-packages 2>/dev/null || pip3 install markdown --quiet
fi

# === Max concurrent sessions limit ===
MAX_SESSIONS=3
active_count=0
for pf in /tmp/cmux-md-preview-*.pid; do
  [[ -f "$pf" ]] || continue
  [[ "$pf" == *watcher* ]] && continue
  pid_val=$(cat "$pf" 2>/dev/null || true)
  if [[ -n "$pid_val" ]] && kill -0 "$pid_val" 2>/dev/null; then
    # Don't count if it's the same file (will be replaced)
    if [[ "$pf" == "$PID_FILE" ]]; then continue; fi
    active_count=$((active_count + 1))
  fi
done
if [[ $active_count -ge $MAX_SESSIONS ]]; then
  echo "Error: Maximum $MAX_SESSIONS concurrent preview sessions reached." >&2
  echo "Run stop-preview.sh to clean up existing sessions." >&2
  exit 1
fi

# === Kill existing server ===
if [[ -f "$PID_FILE" ]]; then
  OLD_PID=$(cat "$PID_FILE" 2>/dev/null || true)
  if [[ -n "$OLD_PID" ]] && kill -0 "$OLD_PID" 2>/dev/null; then
    echo "Stopping existing preview server (PID: $OLD_PID)..."
    kill "$OLD_PID" 2>/dev/null || true
    sleep 0.5
    kill -9 "$OLD_PID" 2>/dev/null || true
  fi
  rm -f "$PID_FILE"
fi

# === Kill any watcher process ===
WATCHER_PID_FILE="/tmp/cmux-md-preview-watcher-${FILE_ID}.pid"
if [[ -f "$WATCHER_PID_FILE" ]]; then
  OLD_WATCHER=$(cat "$WATCHER_PID_FILE" 2>/dev/null || true)
  if [[ -n "$OLD_WATCHER" ]] && kill -0 "$OLD_WATCHER" 2>/dev/null; then
    kill "$OLD_WATCHER" 2>/dev/null || true
  fi
  rm -f "$WATCHER_PID_FILE"
fi

# === Setup serve directory ===
mkdir -p "$SERVE_DIR"

# === Generate HTML ===
generate_html() {
  local md_path="$1"
  python3 "$SCRIPT_DIR/render_html.py" "$md_path" "$HTML_FILE"
  cp "$HTML_FILE" "$SERVE_DIR/index.html"
}

generate_html "$MD_FILE"
echo "HTML generated: $HTML_FILE"

# === Start HTTP server ===
cd "$SERVE_DIR"
python3 -m http.server "$PORT" --bind 127.0.0.1 &>/dev/null &
SERVER_PID=$!
echo "$SERVER_PID" > "$PID_FILE"
echo "Preview server started on http://localhost:$PORT (PID: $SERVER_PID)"

# === Start file watcher (md5 polling) ===
(
  get_hash() {
    if command -v md5sum &>/dev/null; then
      md5sum "$1" 2>/dev/null | cut -d' ' -f1
    else
      md5 -q "$1" 2>/dev/null
    fi
  }

  LAST_HASH=$(get_hash "$MD_FILE")

  while true; do
    sleep 1
    if [[ ! -f "$MD_FILE" ]]; then
      continue
    fi
    CURRENT_HASH=$(get_hash "$MD_FILE")
    if [[ "$CURRENT_HASH" != "$LAST_HASH" ]]; then
      LAST_HASH="$CURRENT_HASH"
      generate_html "$MD_FILE" 2>/dev/null || true
    fi
  done
) &
WATCHER_PID=$!
echo "$WATCHER_PID" > "$WATCHER_PID_FILE"
echo "File watcher started (PID: $WATCHER_PID)"

# === Open browser split in cmux ===
if [[ -n "${CMUX_WORKSPACE_ID:-}" ]]; then
  cmux browser open-split "http://localhost:$PORT" 2>/dev/null || true
  echo "Browser panel opened via cmux"
else
  echo "Note: Not in cmux environment. Open http://localhost:$PORT manually."
fi

echo "Ready! Editing $MD_FILE will auto-refresh the preview."
