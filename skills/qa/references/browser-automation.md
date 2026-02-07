# 브라우저 자동화 가이드

agent-browser 사용법, 실행 패턴, 검증 방법.

## 목차

1. [명령어](#명령어)
2. [셀렉터](#셀렉터)
3. [실행 흐름](#실행-흐름)
4. [검증](#검증)
5. [에러 핸들링](#에러-핸들링)
6. [시나리오 예시](#시나리오-예시)

---

## 명령어

### 옵션

```bash
--profile <name>    # 세션 프로필
--headed            # 브라우저 창 표시
```

### 탐색

| 명령어 | 용도 |
|-------|------|
| `open <url>` | URL 이동 |
| `snapshot -i` | 인터랙티브 요소 (ref 포함) |
| `wait <sel\|ms>` | 대기 |

### 상호작용

| 명령어 | 용도 |
|-------|------|
| `click <sel>` | 클릭 |
| `fill <sel> <text>` | 입력 (기존 지움) |
| `select <sel> <val>` | 드롭다운 |
| `upload <sel> <file>` | 파일 업로드 |
| `press <key>` | 키 입력 |

### 정보 추출

| 명령어 | 용도 |
|-------|------|
| `get text <sel>` | 텍스트 |
| `get url` | 현재 URL |
| `get count <sel>` | 요소 개수 |
| `is visible <sel>` | 표시 여부 |
| `is enabled <sel>` | 활성화 여부 |
| `screenshot <path>` | 스크린샷 |

---

## 셀렉터

| 패턴 | 예시 |
|-----|------|
| `@refN` | `@e5` (snapshot에서) |
| CSS | `button.primary` |
| `text=` | `text=저장` |
| `role=` | `role=dialog` |

---

## 실행 흐름

```
준비 → 실행 → 대기 → 검증 → 기록
```

### 준비

```bash
open <url> --profile <name>
get url  # 로그인 페이지 체크
screenshot /tmp/qa-<id>-init.png
```

### 실행

```bash
snapshot -i
click @refN
fill @refM "값"
```

### 대기

| 상황 | 방법 |
|-----|------|
| 요소 대기 | `wait <selector>` |
| 시간 대기 | `wait 2000` |
| API 응답 | `wait 2000` + 요소 확인 |

### 기록

```bash
screenshot /tmp/qa-<id>-result.png
```

---

## 검증

### 검증 유형

| 유형 | 방법 |
|-----|------|
| 존재 | `is visible <sel>` |
| 텍스트 | `get text <sel>` → 비교 |
| 상태 | `is enabled`, `is checked` |
| 개수 | `get count <sel>` |
| URL | `get url` → 패턴 매칭 |

### 판단 기준

| 결과 | 조건 |
|-----|------|
| **PASS** | 모든 검증 통과 |
| **FAIL** | 검증 실패 |
| **BLOCKED** | 선행 조건 미충족 (로그인, 데이터) |

### 실패 시

```bash
screenshot /tmp/qa-<id>-fail.png
get url
console --clear
```

---

## 에러 핸들링

### 요소 못 찾음

1. `snapshot -i`로 상태 확인
2. 다른 셀렉터 시도
3. 3회 실패 → FAIL + 스크린샷

### 타임아웃

1. wait 시간 증가
2. 새로고침 재시도
3. 지속 → BLOCKED

---

## 시나리오 예시

### 폼 제출

```bash
open <url> --profile <name>
snapshot -i
fill @input1 "값1"
fill @input2 "값2"
click @submitBtn
wait 2000
snapshot -i
screenshot /tmp/qa-result.png
```

### 모달

```bash
click @openBtn
wait role=dialog
snapshot -i
click @action
wait 1000
is visible role=dialog  # false면 성공
```

### 파일 업로드

```bash
upload @fileInput /tmp/test.csv
wait 2000
snapshot -i
screenshot /tmp/qa-preview.png
```

---

## 스크린샷 타이밍

| 시점 | 파일명 |
|-----|--------|
| 시작 | `qa-<id>-init.png` |
| 실패 | `qa-<id>-fail.png` |
| 완료 | `qa-<id>-result.png` |
