# GitHub 연동 문제 해결 가이드

## 현재 상태 확인

Repository: `bangilhan/tt_combat_simulation_data`

## 일반적인 문제들

### 1. Repository를 찾을 수 없음 (404 에러)

**원인:**
- Repository가 아직 생성되지 않음
- Repository 이름이 잘못됨
- Repository가 삭제됨

**해결 방법:**
1. GitHub에서 repository가 실제로 존재하는지 확인
   - https://github.com/bangilhan/tt_combat_simulation_data 접속
2. Repository 이름 확인
   - `index.html`의 1317번째 줄에서 repository 이름 확인
   - 현재: `bangilhan/tt_combat_simulation_data`
3. Repository 생성
   ```bash
   # GitHub 웹에서 생성하거나
   # 또는 git 명령어로
   git init
   git remote add origin git@github.com:bangilhan/tt_combat_simulation_data.git
   ```

### 2. 접근 권한 없음 (403 에러)

**원인:**
- Repository가 Private
- API rate limit 초과

**해결 방법:**
1. Repository를 Public으로 변경
   - Settings → Danger Zone → Change repository visibility
2. 또는 Personal Access Token 사용 (향후 구현 필요)

### 3. Repository가 비어있음

**원인:**
- CSV 파일이 아직 업로드되지 않음

**해결 방법:**
1. CSV 파일 업로드
   ```bash
   git add *.csv
   git commit -m "Add CSV files"
   git push origin main
   ```
2. 또는 GitHub 웹에서 직접 업로드
   - Add file → Upload files

### 4. 네트워크 오류

**원인:**
- 인터넷 연결 문제
- GitHub 서버 문제

**해결 방법:**
1. 네트워크 연결 확인
2. GitHub 상태 확인: https://www.githubstatus.com/
3. 브라우저 콘솔에서 자세한 에러 확인

## 테스트 방법

### 1. 브라우저 콘솔에서 테스트

```javascript
// Repository 존재 확인
fetch('https://api.github.com/repos/bangilhan/tt_combat_simulation_data')
  .then(r => r.json())
  .then(data => console.log(data))
  .catch(err => console.error(err));

// 파일 목록 확인
fetch('https://api.github.com/repos/bangilhan/tt_combat_simulation_data/contents')
  .then(r => r.json())
  .then(data => console.log(data))
  .catch(err => console.error(err));
```

### 2. PowerShell에서 테스트

```powershell
# Repository 정보 확인
$response = Invoke-WebRequest -Uri "https://api.github.com/repos/bangilhan/tt_combat_simulation_data" -UseBasicParsing
$response.Content | ConvertFrom-Json

# 파일 목록 확인
$response = Invoke-WebRequest -Uri "https://api.github.com/repos/bangilhan/tt_combat_simulation_data/contents" -UseBasicParsing
$response.Content | ConvertFrom-Json
```

## 현재 Repository 상태 확인

다음 명령어로 확인:

```powershell
# Repository 존재 여부 확인
try {
    $repo = Invoke-WebRequest -Uri "https://api.github.com/repos/bangilhan/tt_combat_simulation_data" -UseBasicParsing
    Write-Host "Repository 존재함" -ForegroundColor Green
    $repo.Content | ConvertFrom-Json | Select-Object name, full_name, private, default_branch
} catch {
    Write-Host "Repository를 찾을 수 없음: $_" -ForegroundColor Red
}

# 파일 목록 확인
try {
    $contents = Invoke-WebRequest -Uri "https://api.github.com/repos/bangilhan/tt_combat_simulation_data/contents" -UseBasicParsing
    $files = $contents.Content | ConvertFrom-Json
    Write-Host "파일 수: $($files.Count)" -ForegroundColor Green
    $files | Select-Object name, type, size | Format-Table
} catch {
    Write-Host "파일 목록을 가져올 수 없음: $_" -ForegroundColor Red
}
```

## 다음 단계

1. Repository가 존재하는지 확인
2. Repository가 Public인지 확인
3. CSV 파일이 업로드되었는지 확인
4. 브라우저 콘솔에서 자세한 에러 메시지 확인
