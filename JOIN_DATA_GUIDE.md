# 조인 데이터 처리 가이드

## 개요

시뮬레이션은 나중에 다음 정보들을 조인할 수 있도록 구조화되어 있습니다:
- **팀 정보** (team)
- **맵 정보** (map)
- **OS 정보** (os): Windows, Mac, Linux 등
- **입력 디바이스 타입** (input_device): keyboard_mouse, console 등
- **캐릭터 정보** (character)

## 데이터 구조

### 1. 플레이어 객체 구조

각 플레이어 객체는 다음 필드들을 포함합니다:

```javascript
{
    name: "player_id",           // player_id
    team: "team_name",            // 팀 정보
    position: [x, z, y],          // 위치
    health: 100,                  // 체력
    weapon: 1,                    // 무기 ID
    yaw: 0.0,                     // 수평 각도
    pitch: 0.0,                   // 수직 각도
    map: "map_name",              // 맵 정보 (조인)
    os: "Windows",                // OS 정보 (조인)
    input_device: "keyboard_mouse", // 입력 디바이스 (조인)
    character: "character_name"   // 캐릭터 정보 (조인)
}
```

### 2. 메타데이터 구조

```javascript
{
    metadata: {
        matchInfo: {
            match_id: "match_id",
            os_distribution: {
                "Windows": 5,
                "Mac": 3
            },
            input_device_distribution: {
                "keyboard_mouse": 6,
                "console": 2
            },
            character_distribution: {
                "character1": 4,
                "character2": 4
            }
        },
        playerMetadata: {
            "player_id": {
                team: "team_name",
                map: "map_name",
                os: "Windows",
                input_device: "keyboard_mouse",
                character: "character_name"
            }
        }
    }
}
```

## 조인 방법

### 방법 1: CSV에 직접 포함

CSV 파일에 다음 컬럼들을 추가하면 자동으로 인식됩니다:
- `team` 또는 `team_name`
- `map` 또는 `map_name`
- `os` 또는 `os_type`
- `input_device` 또는 `input_device_type`
- `character` 또는 `character_name`

### 방법 2: 별도 조인 함수 사용

나중에 별도 데이터 소스에서 조인할 경우, `enrichPlayerData()` 함수를 사용할 수 있습니다:

```javascript
// 예시: 별도 API나 파일에서 조인 데이터 가져오기
async function enrichPlayerData(simulation) {
    const joinData = await fetchJoinData(); // 별도 소스에서 데이터 가져오기
    
    // 각 플레이어의 메타데이터 업데이트
    simulation.data.positions.forEach(tickData => {
        tickData.players.forEach(player => {
            const joinInfo = joinData[player.name];
            if (joinInfo) {
                player.team = joinInfo.team || player.team;
                player.map = joinInfo.map || player.map;
                player.os = joinInfo.os || player.os;
                player.input_device = joinInfo.input_device || player.input_device;
                player.character = joinInfo.character || player.character;
            }
        });
    });
    
    // 메타데이터도 업데이트
    Object.keys(joinData).forEach(playerId => {
        if (simulation.data.metadata.playerMetadata[playerId]) {
            Object.assign(simulation.data.metadata.playerMetadata[playerId], joinData[playerId]);
        }
    });
    
    // 분포 재계산
    simulation.recalculateDistributions();
}
```

### 방법 3: 데이터베이스 조인

데이터베이스에서 조인할 경우:

```sql
-- 예시 쿼리
SELECT 
    d.*,
    t.team_name,
    m.map_name,
    p.os_type,
    p.input_device_type,
    p.character_name
FROM tt_aimbot_detection_data d
LEFT JOIN teams t ON d.player_id = t.player_id
LEFT JOIN maps m ON d.match_id = m.match_id
LEFT JOIN player_profiles p ON d.player_id = p.player_id
```

## UI에서 사용

### 플레이어 정보 표시

플레이어 정보는 다음 위치에서 표시됩니다:
- 플레이어 라벨 (3D 시뮬레이션)
- 플레이어 목록 (Info 탭)
- 분석 보고서

### 필터링 및 그룹화

나중에 다음 기능들을 추가할 수 있습니다:
- OS별 필터링
- 입력 디바이스별 필터링
- 캐릭터별 필터링
- 팀별 그룹화

## 현재 상태

현재는 조인 데이터가 없어도 시뮬레이션이 정상 동작합니다. 조인 데이터가 추가되면 자동으로 인식되어 사용됩니다.

## 주의사항

1. **성능**: 조인 데이터가 많을 경우 처리 시간이 늘어날 수 있습니다.
2. **메모리**: 모든 플레이어의 메타데이터를 메모리에 저장하므로, 플레이어 수가 많을 경우 메모리 사용량이 증가할 수 있습니다.
3. **데이터 일관성**: 조인 데이터는 `player_id`를 기준으로 매칭되므로, `player_id`가 일관되게 유지되어야 합니다.
