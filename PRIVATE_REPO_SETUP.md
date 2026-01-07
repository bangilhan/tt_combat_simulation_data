# Private Repository 사용 가이드

## 현재 상황

현재 코드는 **Public repository**를 기준으로 작성되어 있습니다.

## 옵션 1: Public Repository 사용 (권장)

**장점:**
- 설정이 간단함
- 현재 코드 그대로 사용 가능
- 추가 인증 불필요

**단점:**
- 누구나 repository를 볼 수 있음
- CSV 파일이 공개됨

**사용 방법:**
1. Repository를 Public으로 설정
2. 현재 코드 그대로 사용

## 옵션 2: Private Repository + Personal Access Token

**장점:**
- 데이터 보안
- 접근 제어 가능

**단점:**
- Personal Access Token 생성 필요
- 코드 수정 필요
- Token 관리 필요

## Private Repository 사용 시 필요한 작업

### 1. Personal Access Token 생성

1. GitHub → Settings → Developer settings → Personal access tokens → Tokens (classic)
2. "Generate new token (classic)" 클릭
3. Note: "Combat Simulation Access" 입력
4. Expiration: 원하는 기간 선택
5. Scopes: `repo` 체크 (Private repository 접근)
6. "Generate token" 클릭
7. **Token을 복사해두세요** (다시 볼 수 없습니다)

### 2. 코드 수정 필요

현재 코드는 Public repository만 지원합니다. Private를 사용하려면:

```javascript
// 현재 (Public)
const response = await fetch(`https://api.github.com/repos/${repo}/contents`);

// Private 사용 시 (Token 필요)
const token = 'YOUR_PERSONAL_ACCESS_TOKEN';
const response = await fetch(`https://api.github.com/repos/${repo}/contents`, {
    headers: {
        'Authorization': `token ${token}`
    }
});
```

### 3. 보안 고려사항

**중요:** Token을 코드에 직접 넣으면 안 됩니다!

**안전한 방법:**
1. 환경 변수 사용 (서버 사이드)
2. 사용자 입력으로 받기 (클라이언트 사이드)
3. 서버 프록시 사용 (가장 안전)

## 권장 사항

**CSV 파일이 민감한 정보를 포함하지 않는다면:**
- Public repository 사용 권장
- 설정이 간단하고 현재 코드 그대로 사용 가능

**CSV 파일이 민감한 정보를 포함한다면:**
- Private repository + 서버 프록시 사용 권장
- Token을 클라이언트에 노출하지 않도록 주의

## 현재 코드 상태

현재 `index.html`은 Public repository를 기준으로 작성되어 있습니다.
Private를 사용하려면 코드 수정이 필요합니다.
