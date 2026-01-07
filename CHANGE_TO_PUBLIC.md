# Repository를 Public으로 변경하는 방법

## 단계별 가이드

### 1단계: Settings로 이동
1. https://github.com/bangilhan/tt_combat_simulation_data 접속
2. 상단 메뉴에서 **"Settings"** 클릭

### 2단계: Danger Zone 찾기
1. Settings 페이지에서 **맨 아래로 스크롤**
2. **"Danger Zone"** 섹션 찾기 (빨간색 테두리)

### 3단계: Visibility 변경
1. **"Change repository visibility"** 클릭
2. 드롭다운에서 **"Make public"** 선택
3. 확인 창이 나타나면:
   - Repository 이름 입력: `bangilhan/tt_combat_simulation_data`
   - 또는 `tt_combat_simulation_data` 입력
4. **"I understand, change repository visibility"** 클릭

### 4단계: GitHub Pages 활성화
1. Settings → **"Pages"** 메뉴로 다시 이동
2. **"Build and deployment"** 섹션에서:
   - Source: **"Deploy from a branch"** 선택 (이미 선택되어 있을 수 있음)
   - Branch: **"main"** 선택
   - Folder: **"/ (root)"** 선택
3. **"Save"** 버튼 클릭

### 5단계: 배포 완료 대기
- 몇 분 후 배포 완료
- 배포된 URL 확인:
  ```
  https://bangilhan.github.io/tt_combat_simulation_data/
  ```

## 주의사항
- Public으로 변경하면 누구나 코드를 볼 수 있습니다
- CSV 파일도 공개됩니다
- 민감한 정보가 있다면 확인 후 변경하세요
