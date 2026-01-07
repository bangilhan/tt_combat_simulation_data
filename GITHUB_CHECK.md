# GitHub Repository 상태 확인

## 현재 상황

Repository: `bangilhan/tt_combat_simulation_data`

**상태**: 404 Not Found

## 가능한 원인

1. **Repository가 아직 생성되지 않음**
   - GitHub에서 repository를 생성해야 합니다
   - https://github.com/new 에서 생성

2. **Repository 이름이 다름**
   - 실제 repository 이름 확인 필요
   - `index.html` 1317번째 줄에서 확인 가능

3. **Repository가 Private**
   - Private repository는 인증이 필요합니다
   - Public으로 변경하거나 Personal Access Token 필요

## 확인 방법

### 1. 브라우저에서 직접 확인
https://github.com/bangilhan/tt_combat_simulation_data

### 2. 브라우저 콘솔에서 테스트
```javascript
// Repository 존재 확인
fetch('https://api.github.com/repos/bangilhan/tt_combat_simulation_data')
  .then(r => r.json())
  .then(data => console.log('Repository 정보:', data))
  .catch(err => console.error('에러:', err));

// 파일 목록 확인
fetch('https://api.github.com/repos/bangilhan/tt_combat_simulation_data/contents')
  .then(r => r.json())
  .then(data => console.log('파일 목록:', data))
  .catch(err => console.error('에러:', err));
```

## 해결 방법

### Repository 생성
1. https://github.com/new 접속
2. Repository name: `tt_combat_simulation_data`
3. Public 선택
4. Create repository 클릭

### CSV 파일 업로드
1. 생성한 repository 페이지에서
2. "Add file" → "Upload files" 클릭
3. CSV 파일들을 드래그 앤 드롭
4. "Commit changes" 클릭

또는 Git 명령어:
```bash
git init
git remote add origin git@github.com:bangilhan/tt_combat_simulation_data.git
git add *.csv
git commit -m "Add CSV files"
git push -u origin main
```

## 코드에서 확인할 위치

`index.html` 파일의 1317번째 줄:
```javascript
const repo = 'bangilhan/tt_combat_simulation_data';
```

이 부분을 실제 repository 이름으로 변경하세요.
