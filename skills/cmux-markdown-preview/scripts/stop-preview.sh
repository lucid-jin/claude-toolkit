#!/usr/bin/env bash
set -euo pipefail

# Usage: stop-preview.sh [file.md]
# If file.md given, stop only that session. Otherwise stop ALL sessions.

stopped=0

stop_session() {
  local pid_file="$1"
  local watcher_file="$2"
  local html_file="$3"
  local serve_dir="$4"

  if [[ -f "$pid_file" ]]; then
    PID=$(cat "$pid_file" 2>/dev/null || true)
    if [[ -n "$PID" ]] && kill -0 "$PID" 2>/dev/null; then
      kill "$PID" 2>/dev/null || true
      echo "Preview server stopped (PID: $PID)"
      stopped=1
    fi
    rm -f "$pid_file"
  fi

  if [[ -f "$watcher_file" ]]; then
    WPID=$(cat "$watcher_file" 2>/dev/null || true)
    if [[ -n "$WPID" ]] && kill -0 "$WPID" 2>/dev/null; then
      kill "$WPID" 2>/dev/null || true
      echo "File watcher stopped (PID: $WPID)"
      stopped=1
    fi
    rm -f "$watcher_file"
  fi

  rm -f "$html_file"
  rm -rf "$serve_dir"
}

if [[ -n "${1:-}" ]]; then
  # Stop specific session by file path
  MD_FILE="$(cd "$(dirname "$1")" && pwd)/$(basename "$1")"
  FILE_HASH=$(echo -n "$MD_FILE" | md5 -q 2>/dev/null || echo -n "$MD_FILE" | md5sum | cut -d' ' -f1)
  FILE_ID="${FILE_HASH:0:8}"
  stop_session \
    "/tmp/cmux-md-preview-${FILE_ID}.pid" \
    "/tmp/cmux-md-preview-watcher-${FILE_ID}.pid" \
    "/tmp/cmux-md-preview-${FILE_ID}.html" \
    "/tmp/cmux-md-preview-serve-${FILE_ID}"
else
  # Stop ALL preview sessions (glob pattern match)
  for pid_file in /tmp/cmux-md-preview-*.pid; do
    [[ -f "$pid_file" ]] || continue
    # Extract FILE_ID from pid filename
    base=$(basename "$pid_file")
    if [[ "$base" =~ cmux-md-preview-watcher-(.+)\.pid ]]; then
      fid="${BASH_REMATCH[1]}"
      stop_session \
        "/tmp/cmux-md-preview-${fid}.pid" \
        "/tmp/cmux-md-preview-watcher-${fid}.pid" \
        "/tmp/cmux-md-preview-${fid}.html" \
        "/tmp/cmux-md-preview-serve-${fid}"
    elif [[ "$base" =~ cmux-md-preview-(.+)\.pid ]]; then
      fid="${BASH_REMATCH[1]}"
      stop_session \
        "/tmp/cmux-md-preview-${fid}.pid" \
        "/tmp/cmux-md-preview-watcher-${fid}.pid" \
        "/tmp/cmux-md-preview-${fid}.html" \
        "/tmp/cmux-md-preview-serve-${fid}"
    fi
  done
  # Also clean up legacy (non-hashed) files
  stop_session \
    "/tmp/cmux-md-preview-server.pid" \
    "/tmp/cmux-md-preview-watcher.pid" \
    "/tmp/cmux-md-preview.html" \
    "/tmp/cmux-md-preview-serve"
fi

if [[ $stopped -eq 0 ]]; then
  echo "No preview server was running."
else
  echo "Preview cleanup complete."
fi
