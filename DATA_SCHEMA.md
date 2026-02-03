# 데이터 스키마 정의서

본 문서는 교전 단위 시뮬레이션 및 분석 보고서 시스템에서 사용되는 데이터 스키마를 정의합니다.

## 목차

1. [시뮬레이션 데이터 테이블](#1-시뮬레이션-데이터-테이블)
2. [분석 보고서 데이터 테이블](#2-분석-보고서-데이터-테이블)
3. [조인 관계](#3-조인-관계)
4. [데이터 타입 및 제약사항](#4-데이터-타입-및-제약사항)

---

## 1. 시뮬레이션 데이터 테이블

### 1.1 테이블 개요

**테이블명**: `tt_aimbot_detection_data_*.csv` (또는 동등한 데이터베이스 테이블)

**용도**: 게임 매치 중 플레이어의 틱별 위치, 조준 각도, 체력, 이벤트 정보를 저장하는 시뮬레이션 원본 데이터

**데이터 소스**: 게임 로그에서 추출된 틱 단위 플레이어 상태 및 이벤트 데이터

### 1.2 필수 필드 (Required Fields)

| 필드명 | 데이터 타입 | 설명 | 예시 |
|--------|------------|------|------|
| `tick` | INTEGER | 게임 틱 번호 (순차적 증가) | `12345` |
| `game_time` | FLOAT | 게임 시간 (초 단위) | `123.456` |
| `match_id` | STRING | 매치 고유 ID (조인 키) | `"match_20240101_001"` |
| `player_id` | STRING | 플레이어 계정 ID (조인 키) | `"player_12345"` |
| `player_name` | STRING | 플레이어 이름 (표시용) | `"PlayerName"` |
| `X` | FLOAT | 플레이어 3D 좌표 X축 | `1234.56` |
| `Y` | FLOAT | 플레이어 3D 좌표 Y축 | `2345.67` |
| `Z` | FLOAT | 플레이어 3D 좌표 Z축 | `3456.78` |
| `health` | FLOAT | 플레이어 체력 (0-100) | `75.5` |

### 1.3 선택적 필드 (Optional Fields)

#### 조준 및 무기 정보

| 필드명 | 데이터 타입 | 설명 | 예시 |
|--------|------------|------|------|
| `yaw` | FLOAT (nullable) | 수평 조준 각도 (도 단위) | `45.5` |
| `pitch` | FLOAT (nullable) | 수직 조준 각도 (도 단위) | `-10.2` |
| `equipped_weapon_id` | INTEGER (nullable) | 장착 무기 ID | `101` |

#### 이벤트 필드 (이벤트 발생 시점에만 존재)

| 필드명 | 데이터 타입 | 설명 | 예시 |
|--------|------------|------|------|
| `event_type` | INTEGER (nullable) | 이벤트 타입<br>1=fire (발사)<br>2=hit (명중)<br>3=kill (킬) | `3` |
| `event_src_player_id` | STRING (nullable) | 공격자 플레이어 ID | `"player_12345"` |
| `event_trg_player_id` | STRING (nullable) | 피해자 플레이어 ID | `"player_67890"` |
| `event_src_id` | INTEGER (nullable) | 이벤트 소스 ID (무기 ID 등) | `101` |
| `head_shot_yn` | INTEGER (nullable) | 헤드샷 여부 (0=아니오, 1=예) | `1` |

#### 조인 가능 필드 (선택적, CSV에 포함되거나 별도 테이블에서 조인)

| 필드명 | 데이터 타입 | 설명 | 예시 |
|--------|------------|------|------|
| `team` 또는 `team_name` | STRING (nullable) | 팀 정보 | `"TeamA"` |
| `map` 또는 `map_name` | STRING (nullable) | 맵 정보 | `"Map_Desert"` |
| `os` 또는 `os_type` | STRING (nullable) | OS 정보<br>Unknown/Windows/MacOS/Linux/PS5/XSX | `"Windows"` |
| `input_device` 또는 `input_device_type` | STRING (nullable) | 입력 장치<br>키보드마우스/콘솔 | `"키보드마우스"` |
| `character` 또는 `character_name` | STRING (nullable) | 캐릭터 정보 | `"Character_01"` |

### 1.4 데이터 특성

- **틱 단위 데이터**: 각 틱마다 모든 플레이어의 상태 정보가 기록됨
- **이벤트 발생 시점**: 이벤트가 발생한 틱의 행에만 이벤트 관련 필드가 채워짐
- **누락 가능성**: 특정 틱이나 이벤트가 누락될 수 있음 (데이터 수집 오류 등)
- **시간 순서**: `tick`과 `game_time`은 시간 순서대로 증가

---

## 2. 분석 보고서 데이터 테이블

### 2.1 테이블 개요

**테이블명**: `tt_player_report_data` (예시)

**용도**: 매치별 플레이어 정보, 교전 통계, 탐지 내역, 유저 신고 등 분석 보고서에 필요한 모든 데이터를 저장

**데이터 소스**: 게임 로그 집계, 탐지 시스템 결과, 유저 신고 데이터

### 2.2 매치 정보 (Match Information)

| 필드명 | 데이터 타입 | 설명 | 예시 |
|--------|------------|------|------|
| `match_id` | STRING (PK) | 매치 고유 ID (조인 키) | `"match_20240101_001"` |
| `game_type` | STRING | 게임 타입<br>AI매치/일반매치/이벤트매치/커스텀매치 | `"일반매치"` |
| `team_type` | STRING | 팀 타입<br>솔로/듀오/트리오/스쿼드 | `"솔로"` |
| `map_name` | STRING | 맵 이름 | `"Map_Desert"` |
| `match_start_time` | BIGINT | 매치 시작 시간 (Unix timestamp) | `1704067200` |
| `match_end_time` | BIGINT | 매치 종료 시간 (Unix timestamp) | `1704069000` |

### 2.3 플레이어 정보 (Player Information)

| 필드명 | 데이터 타입 | 설명 | 예시 |
|--------|------------|------|------|
| `account_id` | STRING (PK) | 계정 ID (조인 키) | `"player_12345"` |
| `player_name` | STRING | 유저명 | `"PlayerName"` |
| `character_id` | INTEGER | 여행자 정보 (1-15) | `5` |
| `os` | STRING | OS 정보<br>Unknown/Windows/MacOS/Linux/PS5/XSX | `"Windows"` |
| `input_device` | STRING | 입력 장치<br>키보드마우스/콘솔 | `"키보드마우스"` |

### 2.4 교전 통계 (Combat Statistics)

| 필드명 | 데이터 타입 | 설명 | 예시 |
|--------|------------|------|------|
| `match_id` | STRING (FK) | 매치 ID | `"match_20240101_001"` |
| `account_id` | STRING (FK) | 계정 ID | `"player_12345"` |
| `rank` | INTEGER | 매치 내 순위 | `3` |
| `survival_time` | FLOAT | 생존시간 (초) | `450.5` |
| `kills` | INTEGER | 킬 수 | `12` |
| `deaths` | INTEGER | 데스 수 | `2` |
| `assists` | INTEGER | 어시스트 수 | `5` |
| `total_damage` | INTEGER | 총 데미지 | `3500` |
| `accuracy` | FLOAT | 명중률 (%) | `65.5` |

### 2.5 아이템/스킬 정보 (Item/Skill Information)

| 필드명 | 데이터 타입 | 설명 | 예시 |
|--------|------------|------|------|
| `match_id` | STRING (FK) | 매치 ID | `"match_20240101_001"` |
| `account_id` | STRING (FK) | 계정 ID | `"player_12345"` |
| `item_purchases` | JSON | 아이템 구매 내역<br>배열: `[{item, time, cost}, ...]` | `[{"item": "Weapon_01", "time": 120.5, "cost": 1000}]` |
| `skill_enhancements` | JSON | 스킬 강화 내역<br>배열: `[{skill, level}, ...]` | `[{"skill": "Skill_01", "level": 3}]` |

### 2.6 EAC 탐지 내역 (EAC Detection History)

| 필드명 | 데이터 타입 | 설명 | 예시 |
|--------|------------|------|------|
| `match_id` | STRING (FK) | 매치 ID | `"match_20240101_001"` |
| `account_id` | STRING (FK) | 계정 ID | `"player_12345"` |
| `detected` | BOOLEAN | 탐지 여부 | `true` |
| `aimbot_lstm` | BOOLEAN | Aimbot LSTM 탐지 | `true` |
| `high_crit_rate` | BOOLEAN | 높은 치명타율 탐지 | `false` |
| `high_hit_rate` | BOOLEAN | 높은 명중률 탐지 | `true` |
| `massive_reports` | INTEGER | 대량 신고 수 | `15` |
| `recursive_massive_reports` | BOOLEAN | 재귀적 대량 신고 | `false` |
| `multi_account` | BOOLEAN | 동일 기기 다계정 | `false` |
| `hardware_ban` | BOOLEAN | 하드웨어 밴 | `false` |
| `dma` | BOOLEAN | DMA 탐지 | `false` |
| `details` | TEXT (nullable) | 상세 정보 | `"비정상적인 에임 패턴 탐지"` |

### 2.7 NCGuard 탐지 내역 (NCGuard Detection History)

| 필드명 | 데이터 타입 | 설명 | 예시 |
|--------|------------|------|------|
| `match_id` | STRING (FK) | 매치 ID | `"match_20240101_001"` |
| `account_id` | STRING (FK) | 계정 ID | `"player_12345"` |
| `detected` | BOOLEAN | 탐지 여부 | `true` |
| `details` | TEXT (nullable) | 상세 정보 | `"NCGuard 패턴 탐지됨"` |

### 2.8 사내 에임봇 탐지 내역 (Internal Aimbot Detection History)

| 필드명 | 데이터 타입 | 설명 | 예시 |
|--------|------------|------|------|
| `match_id` | STRING (FK) | 매치 ID | `"match_20240101_001"` |
| `account_id` | STRING (FK) | 계정 ID | `"player_12345"` |
| `detected` | BOOLEAN | 탐지 여부 | `true` |
| `details` | TEXT (nullable) | 상세 정보 | `"사내 에임봇 탐지 모델에서 이상 패턴 발견"` |
| `kill_trace_data` | JSON (nullable) | 킬별 에임 궤적 데이터<br>배열: 킬 이벤트 기준 ±30틱 범위의 yaw/pitch 변화량 | `[{"kill_tick": 12345, "trace": [...]}]` |

### 2.9 룰기반 탐지 내역 (Rule-based Detection History)

| 필드명 | 데이터 타입 | 설명 | 예시 |
|--------|------------|------|------|
| `match_id` | STRING (FK) | 매치 ID | `"match_20240101_001"` |
| `account_id` | STRING (FK) | 계정 ID | `"player_12345"` |
| `detected` | BOOLEAN | 탐지 여부 | `true` |
| `respawn_hack` | BOOLEAN | 리스폰 핵 | `false` |
| `time_energy_hack` | BOOLEAN | 타임에너지 핵 | `true` |
| `cooldown_ignore_hack` | BOOLEAN | 쿨타임 무시 핵 | `false` |
| `range_hack` | BOOLEAN | 사거리 핵 | `false` |
| `movement_hack` | BOOLEAN | 이동 핵 | `false` |
| `install_hack` | BOOLEAN | 설치 핵 | `false` |
| `details` | TEXT (nullable) | 상세 정보 | `"타임에너지 핵 패턴 탐지"` |

### 2.10 유저 신고 내역 (User Report History)

| 필드명 | 데이터 타입 | 설명 | 예시 |
|--------|------------|------|------|
| `match_id` | STRING (FK) | 매치 ID | `"match_20240101_001"` |
| `account_id` | STRING (FK) | 신고 대상 계정 ID | `"player_12345"` |
| `reporter_account_id` | STRING | 신고자 계정 ID | `"player_67890"` |
| `reason_index` | INTEGER | 신고 사유 인덱스 (1-5) | `2` |
| `reason_text` | STRING | 신고 사유 텍스트 | `"부정행위 의심"` |
| `report_time` | BIGINT | 신고 시간 (Unix timestamp) | `1704067500` |
| `report_date` | DATE | 신고 날짜 | `2024-01-01` |

---

## 3. 조인 관계

### 3.1 조인 키

시뮬레이션 데이터 테이블과 분석 보고서 데이터 테이블은 다음 키로 조인됩니다:

- **매치 조인**: `match_id = match_id`
- **플레이어 조인**: `player_id = account_id`

### 3.2 조인 예시

```sql
SELECT 
    sim.tick,
    sim.game_time,
    sim.X, sim.Y, sim.Z,
    sim.health,
    sim.yaw, sim.pitch,
    sim.event_type,
    report.player_name,
    report.kills,
    report.deaths,
    report.eac_detected,
    report.ncguard_detected,
    report.internal_aimbot_detected,
    report.rule_based_detected
FROM 
    tt_aimbot_detection_data_* AS sim
    JOIN tt_player_report_data AS report
    ON sim.match_id = report.match_id 
    AND sim.player_id = report.account_id
WHERE 
    sim.match_id = 'match_20240101_001'
    AND sim.player_id = 'player_12345'
ORDER BY 
    sim.tick ASC;
```

### 3.3 조인 시 주의사항

- 시뮬레이션 데이터는 틱 단위로 다수의 행을 가지므로, 조인 시 1:N 관계가 됩니다.
- 분석 보고서 데이터는 매치-플레이어 조합당 1개의 행을 가집니다.
- 탐지 내역(EAC, NCGuard, 사내 ML, 룰기반)은 별도 테이블로 분리하거나 JSON 필드로 저장할 수 있습니다.

---

## 4. 데이터 타입 및 제약사항

### 4.1 데이터 타입 정의

- **INTEGER**: 정수형 (32-bit 또는 64-bit)
- **FLOAT**: 부동소수점 실수형 (32-bit)
- **STRING**: 문자열 (UTF-8 인코딩)
- **BOOLEAN**: 불린형 (true/false 또는 1/0)
- **BIGINT**: 큰 정수형 (64-bit, Unix timestamp 등)
- **DATE**: 날짜형 (YYYY-MM-DD 형식)
- **TEXT**: 긴 문자열 (nullable)
- **JSON**: JSON 형식 데이터 (배열 또는 객체)

### 4.2 제약사항

#### 시뮬레이션 데이터 테이블

- `tick`은 필수이며, 순차적으로 증가해야 합니다.
- `match_id`와 `player_id`는 조인을 위해 필수입니다.
- `X`, `Y`, `Z`는 플레이어 위치 데이터가 있는 경우 필수입니다.
- 이벤트 필드(`event_type`, `event_src_player_id`, `event_trg_player_id` 등)는 이벤트 발생 시점에만 존재합니다.

#### 분석 보고서 데이터 테이블

- `match_id`와 `account_id`는 조인을 위해 필수입니다.
- 탐지 내역의 `detected` 필드는 기본값 `false`를 가집니다.
- JSON 필드(`item_purchases`, `skill_enhancements`, `kill_trace_data`)는 유효한 JSON 형식이어야 합니다.

### 4.3 데이터 정확도 전제

- **시뮬레이션 데이터**: 포맷은 거의 동일하게 유지되며, 특정 틱이나 이벤트가 누락될 수 있습니다.
- **분석 보고서 데이터**: 1월 이후 제공 예정이며, 제공 범위와 시점에 따라 활용 가능 범위가 변동될 수 있습니다.

### 4.4 NULL 처리

- `nullable`로 표시된 필드는 NULL 값을 가질 수 있습니다.
- 이벤트가 발생하지 않은 틱에서는 이벤트 관련 필드가 NULL입니다.
- 조인 데이터가 없는 경우 해당 필드는 NULL이거나 빈 문자열(`''`)일 수 있습니다.

---

## 5. 참고사항

### 5.1 PoC vs 실제 서비스

**PoC (현재 구현)**
- 파일 업로드 방식으로 CSV 데이터를 로드
- Mock 데이터를 사용하여 탐지 결과 생성

**실제 서비스**
- API/스토리지에서 `match_id`와 `account_id`로 조회
- 분석 보고서 테이블에서 실제 데이터를 조인하여 사용

### 5.2 데이터 제공 시점

- **시뮬레이션 데이터**: 현재 사용 중인 필드들이 확인되었으며, 포맷은 거의 동일하게 유지됩니다.
- **분석 보고서 데이터**: 1월 이후 제공 예정입니다.

### 5.3 확장 가능성

본 스키마는 향후 추가 필드나 테이블 확장이 가능하도록 설계되었습니다. 새로운 탐지 시스템이나 통계 항목이 추가될 경우, 기존 스키마를 유지하면서 확장할 수 있습니다.
