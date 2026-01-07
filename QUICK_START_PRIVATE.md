# Private Repository 빠른 시작 가이드

## ✅ 현재 상태

Private repository 지원이 완료되었습니다!

## 🚀 3단계로 시작하기

### 1단계: GitHub Personal Access Token 생성 (약 2분)

1. **GitHub 접속**
   - https://github.com/settings/tokens 접속
   - 또는 GitHub → Settings → Developer settings → Personal access tokens → Tokens (classic)

2. **Token 생성**
   - "Generate new token (classic)" 클릭
   - Note: `Combat Simulation` 입력
   - Expiration: `90 days` (또는 원하는 기간)
   - **중요**: `repo` 체크박스 선택 (Private repository 접근 필수)
   - "Generate token" 클릭

3. **Token 복사**
   - 생성된 Token 복사 (`ghp_`로 시작)
   - ⚠️ **이 페이지를 벗어나면 다시 볼 수 없습니다!**

### 2단계: Repository 설정 (약 1분)

1. **Repository 생성/확인**
   - https://github.com/new 접속
   - Repository name: `tt_combat_simulation_data`
   - **Private** 선택
   - "Create repository" 클릭

2. **CSV 파일 업로드**
   - "Add file" → "Upload files" 클릭
   - CSV 파일들을 드래그 앤 드롭
   - "Commit changes" 클릭

### 3단계: 시뮬레이션에서 사용 (약 1분)

1. **시뮬레이션 열기**
   - `index.html` 파일을 브라우저에서 열기

2. **Token 입력**
   - "파일 로드" 버튼 클릭
   - 팝업 상단의 Token 입력 필드에 Token 붙여넣기
   - "저장" 버튼 클릭

3. **파일 로드**
   - CSV 파일 목록이 표시되면 체크박스로 선택
   - "선택한 파일 로드" 버튼 클릭
   - 시뮬레이션 시작!

## 🔍 확인 사항

### Token이 제대로 작동하는지 확인

브라우저 콘솔(F12)에서 확인:
```javascript
// Token이 저장되었는지 확인
localStorage.getItem('github_pat_token')

// Repository 접근 테스트
fetch('https://api.github.com/repos/bangilhan/tt_combat_simulation_data/contents', {
    headers: {
        'Authorization': 'token YOUR_TOKEN_HERE'
    }
})
.then(r => r.json())
.then(data => console.log('성공:', data))
.catch(err => console.error('실패:', err))
```

### 문제 해결

**403 에러 (접근 권한 없음)**
- Token에 `repo` scope가 있는지 확인
- Token이 만료되지 않았는지 확인
- Repository가 Private인지 확인

**404 에러 (Repository를 찾을 수 없음)**
- Repository 이름이 정확한지 확인: `bangilhan/tt_combat_simulation_data`
- Repository가 생성되었는지 확인

**파일 목록이 안 보임**
- CSV 파일이 업로드되었는지 확인
- 파일 이름이 `.csv`로 끝나는지 확인

## 📝 코드에서 Repository 이름 변경

만약 다른 repository를 사용하려면:

`index.html` 파일의 **1389번째 줄** 근처:
```javascript
const repo = 'bangilhan/tt_combat_simulation_data';
```

이 부분을 원하는 repository 이름으로 변경하세요.

## 🔒 보안 팁

1. **Token 관리**
   - 공용 컴퓨터 사용 후 "삭제" 버튼으로 Token 제거
   - Token이 유출되면 즉시 GitHub에서 삭제

2. **Token 갱신**
   - Token 만료일 전에 새 Token 생성
   - 만료된 Token은 자동으로 작동하지 않음

3. **Repository 접근 제어**
   - Repository Collaborators에서 접근 권한 관리
   - 필요 없는 사람은 제거

## ✅ 체크리스트

- [ ] GitHub Personal Access Token 생성 (`repo` scope 포함)
- [ ] Private Repository 생성 (`tt_combat_simulation_data`)
- [ ] CSV 파일 업로드
- [ ] 시뮬레이션에서 Token 입력 및 저장
- [ ] 파일 목록 확인
- [ ] 시뮬레이션 정상 작동 확인

## 🎉 완료!

이제 Private repository를 사용하여 시뮬레이션을 실행할 수 있습니다!

문제가 발생하면 브라우저 콘솔(F12)에서 에러 메시지를 확인하세요.
