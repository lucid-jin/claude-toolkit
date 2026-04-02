---
name: cmux-markdown-preview
version: 3.0.0
description: >
  cmux 환경에서 마크다운 파일의 실시간 미리보기를 제공합니다.
  python-markdown으로 GitHub 스타일 HTML 변환 후 로컬 서버로 서빙하고,
  cmux browser open-split으로 옆에 브라우저 패널을 열어 실시간 프리뷰를 보여줍니다.
  파일 변경 시 자동으로 HTML을 재생성하며 브라우저가 2초마다 자동 갱신됩니다.

  Use when:
  - 마크다운 파일을 생성하거나 편집할 때
  - '미리보기', 'preview', '어떻게 보이는지' 등을 언급할 때
  - README, 문서 작성 중 결과 확인을 요청할 때

  Do NOT use when:
  - cmux 환경이 아닐 때 ($CMUX_WORKSPACE_ID가 없을 때)
  - 마크다운이 아닌 파일을 다룰 때

  Triggers (KO): 마크다운 미리보기, md 미리보기, 문서 미리보기, 어떻게 보이는지, 프리뷰, 미리보기 켜줘, 프리뷰 열어, 결과 보여줘, 렌더링 결과, 보면서 수정, 실시간으로 보고싶어, README 확인, 어떻게 보여
  Triggers (EN): markdown preview, md preview, preview markdown, how does it look, show preview, render this md, show me the preview, live preview, open preview
---

# cmux Markdown Preview

cmux 환경에서 마크다운 파일의 실시간 미리보기를 제공하는 스킬입니다.

## 사전 조건

- cmux 환경 (`$CMUX_WORKSPACE_ID` 존재)
- python3 (markdown 모듈은 자동 설치)

## 사용법

### 미리보기 시작

마크다운 파일의 미리보기를 시작하려면:

```bash
~/.claude/skills/cmux-markdown-preview/scripts/serve-markdown.sh <파일경로> [포트]
```

- 기본 포트: 18741
- GitHub 스타일 CSS + 다크모드 대응
- 파일 변경 감지 시 자동 HTML 재생성
- 브라우저 2초마다 자동 갱신

### HTML만 재생성

서버가 이미 실행 중일 때 HTML만 업데이트:

```bash
~/.claude/skills/cmux-markdown-preview/scripts/update-preview.sh <파일경로>
```

### 미리보기 종료

```bash
~/.claude/skills/cmux-markdown-preview/scripts/stop-preview.sh
```

## 워크플로우

1. 사용자가 마크다운 파일 편집/생성 요청
2. 파일 작성 후 `serve-markdown.sh`로 미리보기 서버 시작
3. `cmux browser open-split`으로 브라우저 패널 오픈
4. 파일 수정 시 `update-preview.sh`로 HTML 재생성 (자동 감지도 동작)
5. 작업 완료 시 `stop-preview.sh`로 정리
