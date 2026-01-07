# Vercel 배포 가이드 (Private Repository 지원)

## ✅ Vercel의 장점
- **Private repository 지원** (GitHub Pages와 달리)
- 무료 플랜 제공
- 빠른 배포
- 자동 재배포 (코드 푸시 시)

## 🚀 배포 방법 (약 5분)

### 1단계: Vercel 계정 생성
1. https://vercel.com 접속
2. "Sign Up" 클릭
3. "Continue with GitHub" 선택
4. GitHub 계정으로 로그인

### 2단계: 프로젝트 배포
1. Vercel 대시보드에서 **"Add New..." → "Project"** 클릭
2. **"Import Git Repository"** 클릭
3. `bangilhan/tt_combat_simulation_data` 선택
4. **"Import"** 클릭

### 3단계: 배포 설정
- **Framework Preset**: `Other` 선택
- **Root Directory**: `.` (현재 디렉토리)
- **Build Command**: 비워두기 (빌드 불필요)
- **Output Directory**: `.` 선택
- **Install Command**: 비워두기

### 4단계: 배포 실행
1. **"Deploy"** 버튼 클릭
2. 몇 초 후 배포 완료
3. 자동 생성된 URL 확인 (예: `https://tt-combat-simulation-data.vercel.app`)

## 📍 배포 후 사이트 링크

배포가 완료되면 다음과 같은 URL이 생성됩니다:
```
https://tt-combat-simulation-data.vercel.app
또는
https://tt-combat-simulation-data-[랜덤문자].vercel.app
```

## 🔄 자동 재배포

이후 코드를 GitHub에 푸시하면:
- Vercel이 자동으로 감지
- 자동으로 재배포
- 사이트가 자동 업데이트

## 🔒 Private Repository 사용

Vercel은 Private repository도 완벽하게 지원합니다:
- GitHub Personal Access Token 자동 연동
- Private repository 접근 가능
- 시뮬레이션에서 Token 입력하여 사용 가능

## ✅ 배포 확인

1. 배포된 URL 접속
2. 시뮬레이션 화면 확인
3. "파일 로드" 버튼 클릭
4. GitHub에서 CSV 파일 목록 확인

## 🎉 완료!

이제 Private repository를 유지하면서도 웹사이트를 배포할 수 있습니다!
