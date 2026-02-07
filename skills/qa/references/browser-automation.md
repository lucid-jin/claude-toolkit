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

## 요소 탐색 전략 (토큰 절약)

snapshot은 토큰 소모가 크다. 단계적으로 접근:

```
1단계: find        (~0.5K tokens) → 대부분 여기서 해결
2단계: snapshot -ic -d 3  (~1-2K) → 구조 파악 필요시
3단계: snapshot -ic       (~5K)   → 2단계로 안될 때
4단계: 사용자에게 질문           → 그래도 안되면
```

**첫 진입 시**: `snapshot -ic -d 3`으로 구조 파악
**이후**: `find`나 직접 셀렉터(`text=`, `role=`)로 조작

```bash
# 좋음 - find 먼저 시도
agent-browser find "text" "벌크 업로드" click
agent-browser find "role" "button" click --name "저장"

# 좋음 - 직접 셀렉터
agent-browser click "text=업로드"
agent-browser is visible "role=dialog"

# 좋음 - 범위 좁힌 snapshot
agent-browser snapshot -ic -s "role=dialog" -d 3

# 피할 것 - 전체 snapshot 반복
agent-browser snapshot -i
```

---

## 실행 흐름

```
준비 → 실행 → 대기 → 검증 → 기록
```

### 준비

```bash
open <url> --profile <name>
get url  # 로그인 페이지 체크
snapshot -ic -d 3  # 첫 진입: 구조 파악
screenshot /tmp/qa-<id>-init.png
```

### 실행

```bash
find "role" "button" click --name "대상"  # find 우선
click @refN  # ref 알면 직접
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

1. `find`로 다른 텍스트/role 시도
2. `snapshot -ic -d 3`으로 범위 좁혀서 확인
3. 안되면 `snapshot -ic`로 확인
4. 그래도 안되면 → 사용자에게 질문

### 타임아웃

1. wait 시간 증가
2. 새로고침 재시도
3. 지속 → BLOCKED

---

## 시나리오 예시

### 폼 제출

```bash
open <url> --profile <name>
snapshot -ic -d 3  # 첫 진입만
fill @input1 "값1"
fill @input2 "값2"
click @submitBtn
wait 2000
get text ".toast"  # snapshot 대신 직접 확인
screenshot /tmp/qa-result.png
```

### 모달

```bash
find "role" "button" click --name "열기"
wait role=dialog
snapshot -ic -s "role=dialog" -d 3  # 모달 범위만
click @action
wait 1000
is visible role=dialog  # false면 성공
```

### 파일 업로드

```bash
find "text" "업로드" click  # find 우선
upload @fileInput /tmp/test.csv
wait 2000
screenshot /tmp/qa-preview.png
```

---

## 스크린샷 타이밍

| 시점 | 파일명 |
|-----|--------|
| 시작 | `qa-<id>-init.png` |
| 실패 | `qa-<id>-fail.png` |
| 완료 | `qa-<id>-result.png` |
