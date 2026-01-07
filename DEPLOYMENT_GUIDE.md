# 배포 가이드 - 시뮬레이션 사이트 링크 만들기

## 🚀 빠른 배포 방법

### 방법 1: GitHub Pages (추천 - 무료, 간단)

**설정 방법:**

1. **GitHub Repository 페이지로 이동**
   - https://github.com/bangilhan/tt_combat_simulation_data 접속

2. **Settings 메뉴 클릭**
   - Repository 상단의 "Settings" 탭 클릭

3. **Pages 메뉴 선택**
   - 왼쪽 사이드바에서 "Pages" 클릭

4. **배포 설정**
   - Source: "Deploy from a branch" 선택
   - Branch: "main" 선택
   - Folder: "/ (root)" 선택
   - "Save" 클릭

5. **배포 완료 대기**
   - 몇 분 후 배포 완료
   - 배포된 URL이 표시됨

6. **사이트 접속**
   - URL 형식: `https://bangilhan.github.io/tt_combat_simulation_data/`
   - 또는 Settings → Pages에서 확인 가능

---

### 방법 2: Vercel 배포 (빠른 배포)

**설정 방법:**

1. **Vercel 접속**
   - https://vercel.com 접속
   - GitHub 계정으로 로그인

2. **New Project 클릭**
   - "Add New..." → "Project" 클릭

3. **Repository 선택**
   - `bangilhan/tt_combat_simulation_data` 선택
   - "Import" 클릭

4. **배포 설정**
   - Framework Preset: "Other" 선택
   - Root Directory: `.` (현재 디렉토리)
   - Build Command: 비워두기
   - Output Directory: `.` 선택
   - "Deploy" 클릭

5. **배포 완료**
   - 자동으로 URL 생성 (예: `https://tt-combat-simulation-data.vercel.app`)
   - 이후 코드 푸시 시 자동 재배포

---

### 방법 3: 로컬에서 실행 (개발/테스트용)

**PowerShell에서:**
```powershell
# run_local_server.ps1 파일 실행
.\run_local_server.ps1
```

**또는 직접:**
```powershell
python -m http.server 8000
```

그 다음 브라우저에서:
- http://localhost:8000 접속

---

## 📍 예상 사이트 링크

### GitHub Pages
```
https://bangilhan.github.io/tt_combat_simulation_data/
```

### Vercel (배포 후)
```
https://tt-combat-simulation-data.vercel.app
또는
https://tt-combat-simulation-data-[랜덤].vercel.app
```

---

## ✅ 배포 후 확인 사항

1. **사이트 접속 확인**
   - 배포된 URL로 접속
   - 시뮬레이션 화면이 보이는지 확인

2. **파일 로드 테스트**
   - "파일 로드" 버튼 클릭
   - GitHub에서 CSV 파일 목록이 보이는지 확인
   - 파일 선택 후 로드 테스트

3. **Private Repository 사용 시**
   - GitHub Personal Access Token 입력
   - Private repository 접근 확인

---

## 🔧 문제 해결

### GitHub Pages가 작동하지 않는 경우
- Repository가 Public인지 확인
- Settings → Pages에서 배포 상태 확인
- 배포 후 몇 분 기다리기 (최대 10분)

### Vercel 배포 오류
- `vercel.json` 파일이 있는지 확인
- Repository가 연결되어 있는지 확인
- Vercel 대시보드에서 로그 확인

---

## 📝 참고

- GitHub Pages는 무료이지만 Public repository만 지원
- Private repository는 GitHub Pages 사용 불가 (Vercel 사용 권장)
- 파일 크기가 100MB 이상이면 GitHub에 업로드 어려울 수 있음
