# Repository를 Public으로 변경하는 방법

## 이유
GitHub Pages는 **Public repository에서만 무료**로 사용할 수 있습니다.
Private repository에서는 GitHub Enterprise가 필요합니다.

## 변경 방법

1. **Repository 페이지로 이동**
   - https://github.com/bangilhan/tt_combat_simulation_data 접속

2. **Settings 클릭**
   - Repository 상단의 "Settings" 탭

3. **Danger Zone 찾기**
   - Settings 페이지 맨 아래로 스크롤
   - "Danger Zone" 섹션 찾기

4. **Change repository visibility 클릭**
   - "Change repository visibility" 버튼 클릭
   - "Change visibility" 드롭다운에서 "Make public" 선택
   - Repository 이름 입력하여 확인
   - "I understand, change repository visibility" 클릭

5. **GitHub Pages 활성화**
   - Settings → Pages로 다시 이동
   - 이제 Source 선택 옵션이 나타남
   - "Deploy from a branch" 선택
   - Branch: "main" 선택
   - Folder: "/ (root)" 선택
   - Save 클릭

## 주의사항
- Public으로 변경하면 누구나 코드를 볼 수 있습니다
- CSV 파일도 공개됩니다
- 민감한 정보가 있다면 확인 후 변경하세요
