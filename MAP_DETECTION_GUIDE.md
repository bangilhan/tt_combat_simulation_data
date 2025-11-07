# 맵 이름 추출 가이드

## 현재 구현된 방법

### 1. 파일명 기반 추출
CSV 파일명에 맵 이름이 포함되어 있으면 자동으로 추출합니다.
- 지원 맵: anubis, dust2, inferno, mirage, overpass, nuke, vertigo, ancient, cache, train, cobblestone
- 예시: `anubis_match_data.csv` → "Anubis" 자동 감지

### 2. 위치 범위 기반 추론
플레이어 위치 데이터의 범위를 분석하여 알려진 CS2 맵과 매칭합니다.
- 현재 지원 맵: Anubis, Dust2, Inferno, Mirage, Overpass, Nuke, Vertigo, Ancient, Cache, Train
- 30% 이상 유사도일 때 매칭

### 3. 외부 맵 데이터 로드
`map_data.json` 파일이나 GitHub에서 맵 데이터를 자동으로 로드합니다.
- 로컬 파일: `./map_data.json`
- GitHub Raw Content: 설정 가능한 URL
- 외부 소스 실패 시 기본 데이터 사용

## 외부 맵 데이터 사용 방법

### 방법 1: 로컬 map_data.json 파일 사용 (가장 쉬움)
프로젝트 루트에 `map_data.json` 파일을 생성하고 맵 데이터를 추가하세요.

```json
{
  "Anubis": {
    "minX": -2000, "maxX": 2000,
    "minY": -2000, "maxY": 2000,
    "minZ": -100, "maxZ": 500,
    "centerX": 0, "centerY": 0, "centerZ": 200
  }
}
```

### 방법 2: GitHub에서 맵 데이터 호스팅
1. GitHub에 새 리포지토리 생성
2. `maps.json` 파일 업로드
3. `index.html`의 `loadMapData()` 함수에서 URL 수정:
   ```javascript
   'https://raw.githubusercontent.com/your-username/your-repo/main/maps.json'
   ```

### 방법 3: CSV에 맵 이름 컬럼 추가 (권장)
CSV 파일에 `map_name` 또는 `map` 컬럼을 추가하면 가장 정확합니다.

```csv
tick,game_time,map_name,name,X,Y,Z,...
2,1378.6406,anubis,SHIPZ,-400.0,2192.0,25.031248,...
```

### 방법 4: 커뮤니티 맵 데이터베이스 활용
- GitHub에서 공개된 CS2 맵 데이터 리포지토리 검색
- 커뮤니티에서 제공하는 맵 좌표 데이터 활용
- 예: `https://raw.githubusercontent.com/community/cs2-maps/main/data.json`

### 방법 5: CS2 게임 파일(.bsp)에서 추출
- CS2 게임 디렉토리에서 `.bsp` 파일 추출
- Source SDK나 VRF (Valve Resource Format) 도구 사용
- 추출한 데이터를 `map_data.json`에 추가

## 맵 범위 데이터 개선

현재 `detectMapFromBounds()` 함수의 맵 범위는 예시 값입니다. 더 정확한 데이터를 얻으려면:

1. **실제 게임 데이터 수집**: 여러 매치의 플레이어 위치 데이터를 수집하여 각 맵의 실제 범위 계산
2. **공식 맵 데이터**: CS2 게임 파일에서 맵 경계 정보 추출
3. **커뮤니티 데이터**: GitHub 등에서 공유되는 CS2 맵 데이터 활용

## 구현 예시

CSV에 `map_name` 컬럼이 있다면:

```javascript
// processData 함수에서
const mapName = row.map_name || row.map || null;
if (mapName) {
    this.detectedMapName = mapName.trim();
}
```

이렇게 하면 가장 정확한 맵 정보를 얻을 수 있습니다.

