# GitHub Repository 설정 가이드

## 1. 새 Repository 생성

1. GitHub에 로그인
2. 우측 상단의 `+` 버튼 클릭 → `New repository` 선택
3. Repository 이름 입력 (예: `tt_combat_simulation_data`)
4. Public 또는 Private 선택 (Public이면 누구나 접근 가능)
5. `Create repository` 클릭

## 2. CSV 파일 업로드

### 방법 1: 웹 인터페이스 사용
1. 생성한 repository 페이지에서 `Add file` → `Upload files` 클릭
2. CSV 파일들을 드래그 앤 드롭 또는 `choose your files` 클릭
3. `Commit changes` 클릭

### 방법 2: Git 명령어 사용
```bash
# Repository 클론
git clone https://github.com/YOUR_USERNAME/YOUR_REPO_NAME.git
cd YOUR_REPO_NAME

# CSV 파일 복사
cp /path/to/your/*.csv .

# 커밋 및 푸시
git add *.csv
git commit -m "Add CSV data files"
git push origin main
```

## 3. index.html에서 Repository 이름 변경

`index.html` 파일의 `showCSVPopup()` 함수에서 repository 이름을 변경하세요:

```javascript
// 현재 (1314번째 줄 근처)
const repo = 'bangilhan/fps_combat_simulation';

// 변경 예시
const repo = 'YOUR_USERNAME/YOUR_REPO_NAME';
```

## 4. 파일 접근 권한

- **Public Repository**: 누구나 파일을 다운로드할 수 있습니다. GitHub API를 통해 파일 목록을 가져올 수 있습니다.
- **Private Repository**: GitHub Personal Access Token이 필요합니다. (현재 코드는 Public만 지원)

## 5. 여러 CSV 파일 사용

현재 구현된 UI에서는:
- 여러 CSV 파일을 체크박스로 선택할 수 있습니다
- 선택한 모든 파일의 데이터가 자동으로 병합됩니다
- 같은 `match_id`를 가진 파일들이 함께 로드됩니다

## 6. 주의사항

- CSV 파일 이름은 `.csv` 확장자를 가져야 합니다
- 파일 크기가 너무 크면 (수백 MB 이상) GitHub에서 업로드가 실패할 수 있습니다
- GitHub API rate limit: 시간당 60회 (인증 없이), 5000회 (인증 시)

## 7. 문제 해결

### 파일 목록이 보이지 않는 경우
- Repository 이름이 올바른지 확인
- Repository가 Public인지 확인
- 브라우저 콘솔에서 에러 메시지 확인

### 파일 다운로드 실패
- 파일이 실제로 repository에 있는지 확인
- 네트워크 연결 확인
- GitHub 서버 상태 확인
