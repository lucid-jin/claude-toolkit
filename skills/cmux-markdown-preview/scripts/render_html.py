#!/usr/bin/env python3
"""Render markdown file to interactive HTML preview."""
import markdown
import sys
import os

filepath = sys.argv[1]
output = sys.argv[2]

with open(filepath, 'r', encoding='utf-8') as f:
    content = f.read()

filename = os.path.basename(filepath)

import re, json

# Extract header line numbers from raw markdown
header_lines = {}
for i, line in enumerate(content.split('\n'), 1):
    m = re.match(r'^(#{1,6})\s+(.+)', line)
    if m:
        header_lines[m.group(2).strip()] = i

md = markdown.Markdown(extensions=[
    'tables', 'fenced_code', 'codehilite', 'toc', 'nl2br', 'sane_lists'
])
html_body = md.convert(content)
header_lines_json = json.dumps(header_lines, ensure_ascii=False)

html = f'''<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- smart refresh via JS -->
<title>Preview: {filename}</title>
<style>
  :root {{
    --bg: #ffffff; --fg: #24292f; --border: #d0d7de;
    --code-bg: #f6f8fa; --banner-bg: #f6f8fa; --banner-fg: #57606a;
    --link: #0969da; --blockquote-border: #d0d7de; --blockquote-fg: #57606a;
    --table-border: #d0d7de; --table-stripe: #f6f8fa;
    --btn-bg: #f0f3f6; --btn-hover: #d0d7de; --btn-active: #0969da;
    --input-bg: #f6f8fa; --toast-bg: #1f2328; --toast-fg: #ffffff;
  }}
  @media (prefers-color-scheme: dark) {{
    :root {{
      --bg: #0d1117; --fg: #e6edf3; --border: #30363d;
      --code-bg: #161b22; --banner-bg: #161b22; --banner-fg: #8b949e;
      --link: #58a6ff; --blockquote-border: #30363d; --blockquote-fg: #8b949e;
      --table-border: #30363d; --table-stripe: #161b22;
      --btn-bg: #21262d; --btn-hover: #30363d; --btn-active: #58a6ff;
      --input-bg: #161b22; --toast-bg: #e6edf3; --toast-fg: #0d1117;
    }}
  }}
  * {{ box-sizing: border-box; margin: 0; padding: 0; }}
  body {{ font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", "Noto Sans", Helvetica, Arial, sans-serif; font-size: 16px; line-height: 1.6; color: var(--fg); background: var(--bg); }}
  .preview-banner {{ position: sticky; top: 0; z-index: 100; background: var(--banner-bg); border-bottom: 1px solid var(--border); padding: 8px 24px; font-size: 13px; color: var(--banner-fg); display: flex; align-items: center; gap: 8px; }}
  .preview-banner .dot {{ width: 8px; height: 8px; background: #3fb950; border-radius: 50%; display: inline-block; }}
  .content {{ max-width: 880px; margin: 0 auto; padding: 32px 24px; }}
  h1, h2, h3, h4, h5, h6 {{ margin-top: 24px; margin-bottom: 16px; font-weight: 600; line-height: 1.25; }}
  h1 {{ font-size: 2em; padding-bottom: 0.3em; border-bottom: 1px solid var(--border); }}
  h2 {{ font-size: 1.5em; padding-bottom: 0.3em; border-bottom: 1px solid var(--border); }}
  h3 {{ font-size: 1.25em; }}
  p {{ margin-bottom: 16px; }}
  a {{ color: var(--link); text-decoration: none; }}
  a:hover {{ text-decoration: underline; }}
  code {{ background: var(--code-bg); padding: 0.2em 0.4em; border-radius: 6px; font-size: 85%; font-family: ui-monospace, SFMono-Regular, "SF Mono", Menlo, Consolas, monospace; }}
  pre {{ background: var(--code-bg); padding: 16px; border-radius: 6px; overflow-x: auto; margin-bottom: 16px; line-height: 1.45; }}
  pre code {{ background: none; padding: 0; font-size: 85%; }}
  blockquote {{ border-left: 4px solid var(--blockquote-border); color: var(--blockquote-fg); padding: 0 16px; margin-bottom: 16px; }}
  ul, ol {{ padding-left: 2em; margin-bottom: 16px; }}
  li + li {{ margin-top: 4px; }}
  table {{ border-collapse: collapse; width: 100%; margin-bottom: 16px; }}
  th, td {{ border: 1px solid var(--table-border); padding: 6px 13px; }}
  th {{ font-weight: 600; }}
  tr:nth-child(even) {{ background: var(--table-stripe); }}
  hr {{ border: none; border-top: 1px solid var(--border); margin: 24px 0; }}
  img {{ max-width: 100%; }}
  .codehilite {{ background: var(--code-bg); padding: 16px; border-radius: 6px; overflow-x: auto; margin-bottom: 16px; }}
  /* === Interactive UI === */
  .section-header {{ display: flex; align-items: center; gap: 8px; position: relative; }}
  .section-header h1, .section-header h2, .section-header h3 {{ flex: 1; }}
  .section-actions {{ display: flex; gap: 4px; opacity: 0; transition: opacity 0.15s; flex-shrink: 0; }}
  .section-header:hover .section-actions {{ opacity: 1; }}
  .btn-icon {{ background: var(--btn-bg); border: 1px solid var(--border); border-radius: 6px; padding: 4px 8px; cursor: pointer; font-size: 12px; color: var(--banner-fg); transition: all 0.15s; white-space: nowrap; }}
  .btn-icon:hover {{ background: var(--btn-hover); }}
  .btn-icon:active {{ color: var(--btn-active); }}
  .comment-box {{ display: none; margin: 8px 0 16px; padding: 8px 12px; background: var(--input-bg); border: 1px solid var(--border); border-radius: 8px; }}
  .comment-box.open {{ display: flex; gap: 8px; align-items: center; }}
  .comment-box input {{ flex: 1; background: var(--bg); border: 1px solid var(--border); border-radius: 6px; padding: 6px 10px; font-size: 13px; color: var(--fg); outline: none; }}
  .comment-box input:focus {{ border-color: var(--btn-active); }}
  .comment-box input::placeholder {{ color: var(--banner-fg); opacity: 0.6; }}
  .comment-box button {{ background: var(--btn-active); color: #fff; border: none; border-radius: 6px; padding: 6px 12px; font-size: 12px; cursor: pointer; white-space: nowrap; }}
  .comment-box .btn-cancel {{ background: var(--btn-bg); color: var(--banner-fg); border: 1px solid var(--border); padding: 4px 8px; }}
  .comment-box .hint {{ font-size: 11px; color: var(--banner-fg); white-space: nowrap; }}
  #float-btn {{ display: none; position: fixed; z-index: 200; background: var(--toast-bg); color: var(--toast-fg); border: none; border-radius: 6px; padding: 6px 12px; font-size: 12px; cursor: pointer; box-shadow: 0 2px 8px rgba(0,0,0,0.2); }}
  #toast {{ display: none; position: fixed; bottom: 24px; left: 50%; transform: translateX(-50%); background: var(--toast-bg); color: var(--toast-fg); padding: 10px 20px; border-radius: 8px; font-size: 13px; z-index: 300; box-shadow: 0 2px 8px rgba(0,0,0,0.3); }}
</style>
</head>
<body>
<div class="preview-banner">
  <span class="dot"></span>
  Preview: {filename}
</div>
<div class="content" id="md-content">
{html_body}
</div>
<button id="float-btn">Copy prompt for selection</button>
<div id="toast"></div>
<script>
const FILE = {repr(filepath)};
const FNAME = {repr(filename)};
const HEADER_LINES = {header_lines_json};

function toast(msg) {{
  const t = document.getElementById('toast');
  t.textContent = msg;
  t.style.display = 'block';
  setTimeout(() => t.style.display = 'none', 2500);
}}

function copyText(text) {{
  const short = text.length > 60 ? text.slice(0, 60) + '...' : text;
  const msg = 'Copied to clipboard! Paste into Claude Code';
  navigator.clipboard.writeText(text).then(() => toast(msg)).catch(() => {{
    const ta = document.createElement('textarea');
    ta.value = text;
    document.body.appendChild(ta);
    ta.select();
    document.execCommand('copy');
    document.body.removeChild(ta);
    toast(msg);
  }});
}}

function applyInteractiveUI() {{
document.querySelectorAll('#md-content .section-header').forEach(w => {{
  const h = w.querySelector('h1,h2,h3');
  if (h) {{ w.replaceWith(h); }}
}});
document.querySelectorAll('#md-content .comment-box').forEach(b => b.remove());

let _i = 0;
document.querySelectorAll('#md-content h1, #md-content h2, #md-content h3').forEach((h, i) => {{
  const wrapper = document.createElement('div');
  wrapper.className = 'section-header';
  h.parentNode.insertBefore(wrapper, h);
  wrapper.appendChild(h);

  const actions = document.createElement('span');
  actions.className = 'section-actions';
  actions.innerHTML = `
    <button class="btn-icon" data-action="edit" data-idx="${{i}}" data-section="${{h.textContent}}" title="Copy edit prompt">Edit</button>
  `;
  wrapper.appendChild(actions);

  const box = document.createElement('div');
  box.className = 'comment-box';
  box.id = 'cb-' + i;
  box.innerHTML = `<input type="text" placeholder="피드백 입력 후 Enter (빈칸이면 개선 요청)" /><button>Copy</button><button class="btn-cancel">X</button><span class="hint">→ clipboard</span>`;
  wrapper.after(box);
}});
}}
applyInteractiveUI();

// Event delegation - survives DOM replacement
document.addEventListener('click', (e) => {{
  const editBtn = e.target.closest('[data-action="edit"]');
  if (editBtn) {{
    const box = document.getElementById('cb-' + editBtn.dataset.idx);
    if (box) {{ box.classList.toggle('open'); if (box.classList.contains('open')) box.querySelector('input').focus(); }}
    return;
  }}
  const cancelBtn = e.target.closest('.btn-cancel');
  if (cancelBtn) {{
    const box = cancelBtn.parentElement;
    box.querySelector('input').value = '';
    box.classList.remove('open');
    return;
  }}
  const copyBtn = e.target.closest('.comment-box button:not(.btn-cancel)');
  if (copyBtn) {{
    const box = copyBtn.parentElement;
    const input = box.querySelector('input');
    const feedback = input.value.trim();
    const section = box.previousElementSibling.querySelector('h1,h2,h3').textContent;
    const line = HEADER_LINES[section] || '';
    const loc = line ? `${{FILE}}:${{line}}` : FILE;
    copyText(feedback ? `${{loc}} 의 "${{section}}" 섹션: ${{feedback}}` : `${{loc}} 의 "${{section}}" 섹션을 개선해줘`);
    input.value = '';
    box.classList.remove('open');
    return;
  }}
}});
document.addEventListener('keydown', (e) => {{
  if (e.target.matches('.comment-box input')) {{
    if (e.key === 'Enter') e.target.parentElement.querySelector('button:not(.btn-cancel)').click();
    if (e.key === 'Escape') {{ e.target.value = ''; e.target.parentElement.classList.remove('open'); }}
  }}
}});

const fb = document.getElementById('float-btn');
document.addEventListener('mouseup', (e) => {{
  const sel = window.getSelection();
  const text = sel.toString().trim();
  if (text.length > 5 && document.getElementById('md-content').contains(sel.anchorNode)) {{
    fb.style.display = 'block';
    fb.style.left = e.pageX + 'px';
    fb.style.top = (e.pageY - 40) + 'px';
    fb._selectedText = text;
  }} else {{
    fb.style.display = 'none';
  }}
}});
fb.addEventListener('click', () => {{
  const text = fb._selectedText;
  if (text) {{
    const short = text.length > 80 ? text.slice(0, 80) + '...' : text;
    copyText(`${{FNAME}}에서 다음 부분을 개선해줘:\\n"${{short}}"\\n파일 경로: ${{FILE}}`);
  }}
  fb.style.display = 'none';
}});

// === Smart fetch-based refresh: no flicker, preserves scroll & UI state ===
let lastContent = document.getElementById('md-content').innerHTML;

async function checkForUpdates() {{
  try {{
    const res = await fetch('index.html?t=' + Date.now());
    const html = await res.text();
    const parser = new DOMParser();
    const doc = parser.parseFromString(html, 'text/html');
    const newContent = doc.getElementById('md-content');
    if (!newContent) return;

    const newHTML = newContent.innerHTML;
    if (newHTML !== lastContent) {{
      // Save open comment boxes state
      const openBoxes = new Set();
      document.querySelectorAll('.comment-box.open').forEach(b => openBoxes.add(b.id));
      const inputValues = {{}};
      document.querySelectorAll('.comment-box input').forEach(inp => {{
        if (inp.value) inputValues[inp.parentElement.id] = inp.value;
      }});

      // Update content
      document.getElementById('md-content').innerHTML = newHTML;
      lastContent = newHTML;

      // Re-apply interactive buttons
      applyInteractiveUI();

      // Restore comment box state
      openBoxes.forEach(id => {{
        const box = document.getElementById(id);
        if (box) box.classList.add('open');
      }});
      Object.entries(inputValues).forEach(([id, val]) => {{
        const box = document.getElementById(id);
        if (box) box.querySelector('input').value = val;
      }});

      // Update HEADER_LINES from new HTML script
      const scriptTag = doc.querySelector('script');
      if (scriptTag) {{
        const match = scriptTag.textContent.match(/const HEADER_LINES = (.+);/);
        if (match) try {{ Object.assign(HEADER_LINES, JSON.parse(match[1])); }} catch(e) {{}}
      }}
    }}
  }} catch(e) {{}}
}}

setInterval(checkForUpdates, 2000);
</script>
</body>
</html>'''

with open(output, 'w', encoding='utf-8') as f:
    f.write(html)
