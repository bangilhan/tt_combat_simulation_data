# Private Repository 사용 가이드

## 완료된 작업

Private repository 지원을 위해 다음 기능이 추가되었습니다:

1. **GitHub Personal Access Token 입력 UI**
   - 팝업에 Token 입력 필드 추가
   - Token 저장/삭제 기능
   - localStorage에 안전하게 저장

2. **자동 인증 처리**
   - Token이 있으면 Private repository 접근
   - Token이 없으면 Public repository 접근 시도

## 사용 방법

### 1. Personal Access Token 생성

1. GitHub → Settings → Developer settings → Personal access tokens → Tokens (classic)
2. "Generate new token (classic)" 클릭
3. Note: "Combat Simulation Access" 입력
4. Expiration: 원하는 기간 선택 (예: 90 days)
5. **Scopes**: `repo` 체크 (Private repository 접근 필수)
6. "Generate token" 클릭
7. **Token을 복사해두세요** (다시 볼 수 없습니다!)
   - 형식: `ghp_xxxxxxxxxxxxx`

### 2. Token 입력 및 저장

1. 시뮬레이션에서 "파일 로드" 버튼 클릭
2. 팝업 상단의 "GitHub Personal Access Token" 입력 필드에 Token 입력
3. "저장" 버튼 클릭
4. Token은 브라우저 localStorage에 저장됩니다

### 3. Repository 설정

1. Repository를 **Private**으로 설정
2. CSV 파일 업로드
3. 시뮬레이션에서 파일 목록 확인

## 보안 고려사항

### ✅ 안전한 점
- Token은 브라우저 localStorage에만 저장
- 코드에 하드코딩되지 않음
- 사용자가 직접 관리

### ⚠️ 주의사항
- Token은 브라우저에 저장되므로, 다른 사람이 같은 브라우저를 사용하면 접근 가능
- 공용 컴퓨터에서는 사용 후 "삭제" 버튼으로 Token 제거 권장
- Token이 유출되면 즉시 GitHub에서 삭제

### 🔒 Token 삭제 방법
1. GitHub → Settings → Developer settings → Personal access tokens
2. 해당 Token 찾기
3. "Delete" 클릭

또는 시뮬레이션에서:
1. 팝업의 "삭제" 버튼 클릭 (로컬 저장소에서만 삭제)
2. GitHub에서도 삭제 권장

## 동작 방식

### Token이 있는 경우
```
1. 사용자가 Token 입력 및 저장
2. API 호출 시 Authorization header에 Token 포함
3. Private repository 접근 가능
```

### Token이 없는 경우
```
1. API 호출 시 Token 없이 시도
2. Public repository면 접근 가능
3. Private repository면 403 에러
```

## 문제 해결

### 403 에러 (접근 권한 없음)
- Token이 올바른지 확인
- Token에 `repo` scope가 있는지 확인
- Repository가 Private인지 확인

### 404 에러 (Repository를 찾을 수 없음)
- Repository 이름이 정확한지 확인
- Repository가 존재하는지 확인

### Token이 저장되지 않음
- 브라우저가 localStorage를 지원하는지 확인
- 브라우저 설정에서 쿠키/로컬 저장소가 차단되지 않았는지 확인

## 코드 위치

- Token 입력 UI: `index.html` 876-900번째 줄
- Token 관리 함수: `setupGitHubToken()` (1070번째 줄 근처)
- API 호출: `showCSVPopup()` 및 `loadMultipleCSVFiles()` 함수

## 참고

- Token은 `github_pat_token` 키로 localStorage에 저장됩니다
- Token 형식: `ghp_`로 시작하는 40자 문자열
- Token은 만료일이 있으므로 주기적으로 갱신 필요
