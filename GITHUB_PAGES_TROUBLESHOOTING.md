# GitHub Pages 404 오류 해결 방법

## 현재 상황
404 에러가 발생하는 경우, 다음을 확인하세요:

## 1. 배포 대기 시간
- GitHub Pages 배포는 **최대 10분** 걸릴 수 있습니다
- Settings → Pages에서 배포 상태 확인
- "Your site is live at..." 메시지가 나타날 때까지 대기

## 2. 파일 위치 확인
- `index.html` 파일이 **루트 디렉토리**에 있어야 합니다
- `main` 브랜치에 있어야 합니다

## 3. 배포 설정 확인
Settings → Pages에서:
- Source: "Deploy from a branch" 선택
- Branch: "main" 선택
- Folder: "/ (root)" 선택
- Save 클릭

## 4. 배포 상태 확인
1. Settings → Pages로 이동
2. "Your site is live at..." 메시지 확인
3. 배포가 진행 중이면 "Building" 또는 "Deploying" 표시

## 5. 강제 재배포
배포가 안 되면:
1. Repository에서 아무 파일이나 수정 (예: README.md)
2. 커밋 및 푸시
3. GitHub Pages가 자동으로 재배포 시도

## 6. URL 확인
올바른 URL 형식:
```
https://bangilhan.github.io/tt_combat_simulation_data/
```

주의:
- `https://bangilhan.github.io/tt_combat_simulation_data` (끝에 슬래시 없음) ❌
- `https://bangilhan.github.io/tt_combat_simulation_data/` (끝에 슬래시 있음) ✅

## 7. Actions 탭 확인
1. Repository → "Actions" 탭 클릭
2. "pages build and deployment" 워크플로우 확인
3. 에러가 있으면 로그 확인

## 빠른 해결 방법

### 방법 1: 빈 커밋으로 재배포 트리거
```bash
git commit --allow-empty -m "Trigger GitHub Pages deployment"
git push
```

### 방법 2: README 업데이트
```bash
echo "# tt_combat_simulation_data" > README.md
git add README.md
git commit -m "Update README for GitHub Pages"
git push
```

## 확인 사항 체크리스트
- [ ] Repository가 Public인가?
- [ ] index.html이 루트에 있는가?
- [ ] main 브랜치에 파일이 있는가?
- [ ] Settings → Pages에서 배포 설정이 올바른가?
- [ ] 배포 완료까지 충분히 기다렸는가? (최대 10분)
- [ ] URL 끝에 슬래시(/)가 있는가?
