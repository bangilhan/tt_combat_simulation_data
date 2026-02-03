# 분석 보고서 데이터 테이블 스키마

본 문서는 분석 보고서 및 3D 시뮬레이션 통계에 필요한 데이터 테이블 스키마를 정의합니다.

**조인 키**: `match_id` (int64), `player_id` (string) = `Actor_NPGameAccountID`

---

## 1. 매치 정보 (Match Information)

| 필드명 | 데이터 타입 | 설명 | 소스 로그 | 소스 필드 |
|--------|------------|------|----------|----------|
| `match_id` | int64 (PK) | 매치 고유 ID (조인 키) | GameEnd | `Actor_GameOID` |
| `game_type` | uint16 | 게임 타입 | GameEnd | `Actor_GameType` |
| `team_type` | uint16 | 팀 타입 (솔로/듀오/트리오/스쿼드) | GameEnd | `Actor_TeamType` |
| `map_id` | int32 | 맵 번호 | GameEnd | `Actor_GameMap` |
| `match_start_time` | uint64 | 매치 시작 시간 (Unix timestamp ms) | 에임봇 로그 | `timestamp` (최소값) |
| `match_end_time` | uint64 | 매치 종료 시간 (Unix timestamp ms) | GameEnd | `LogTime` |

---

## 2. 플레이어 정보 (Player Information)

| 필드명 | 데이터 타입 | 설명 | 소스 로그 | 소스 필드 |
|--------|------------|------|----------|----------|
| `player_id` | string (PK) | 플레이어 계정 ID (조인 키) | GameEnd | `Actor_NPGameAccountID` |
| `account_id` | int64 | AuthDB AccountNo | GameEnd | `Actor_AccountID` |
| `player_name` | string | 유저명 | GameEnd | `Actor_Name` |
| `character_id` | int32 | 캐릭터 ID (1-15) | GameEnd | `Actor_Char` |
| `os` | int16 | OS 정보 | GameEnd | `Actor_OS` |
| `input_device` | string | 입력 장치 (키보드마우스/콘솔) | GameEnd | `Actor_More` (JSON) |

---

## 3. 교전 통계 (Combat Statistics)

| 필드명 | 데이터 타입 | 설명 | 소스 로그 | 소스 필드 |
|--------|------------|------|----------|----------|
| `match_id` | int64 (FK) | 매치 ID | GameEnd | `Actor_GameOID` |
| `player_id` | string (FK) | 플레이어 계정 ID | GameEnd | `Actor_NPGameAccountID` |
| `rank` | int32 | 최종 순위 | GameEnd | `Entity_Code` |
| `survival_time` | int64 | 생존 시간 (초) | GameEnd | `Entity_ID` |
| `kills` | int64 | 킬 수 | GameEnd | `Data_Num2` |
| `deaths` | int64 | 데스 수 | GameEnd | `Data_Num3` |
| `assists` | int64 | Support 점수 (어시스트) | GameEnd | `Data_Num4` |
| `total_damage` | int64 | 총 데미지 | GameEnd | `Data_Num5` |
| `accuracy` | int64 | 명중률 | GameEnd | `Data_Num6` |

---

## 4. 아이템/스킬 정보 (Item/Skill Information)

| 필드명 | 데이터 타입 | 설명 | 소스 로그 | 소스 필드 |
|--------|------------|------|----------|----------|
| `match_id` | int64 (FK) | 매치 ID | GameEnd | `Actor_GameOID` |
| `player_id` | string (FK) | 플레이어 계정 ID | GameEnd | `Actor_NPGameAccountID` |
| `app1_id` | int32 | 앱1 ID | GameEnd | `Actor_App1` |
| `app1_level` | uint16 | 앱1 레벨 | GameEnd | `Actor_App1Up` |
| `app2_id` | int32 | 앱2 ID | GameEnd | `Actor_App2` |
| `app2_level` | uint16 | 앱2 레벨 | GameEnd | `Actor_App2Up` |
| `app3_id` | int32 | 앱3 ID | GameEnd | `Actor_App3` |
| `app3_level` | uint16 | 앱3 레벨 | GameEnd | `Actor_App3Up` |
| `skill1_level` | uint16 | 스킬1 강화 레벨 | GameEnd | `Actor_Skill1Up` |
| `skill2_level` | uint16 | 스킬2 강화 레벨 | GameEnd | `Actor_Skill2Up` |
| `skill3_level` | uint16 | 스킬3 강화 레벨 | GameEnd | `Actor_Skill3Up` |
| `final_weapon_id` | int32 | 최종 사용 무기 ID | GameEnd | `Actor_Weapon` |
| `final_ingame_level` | int16 | 최종 InGame Level | GameEnd | `Actor_InGameLv` |

---

## 5. EAC 탐지 내역 (EAC Detection History)

| 필드명 | 데이터 타입 | 설명 | 소스 로그 | 소스 필드 |
|--------|------------|------|----------|----------|
| `match_id` | int64 (FK) | 매치 ID | EAC 탐지 | `match_id` |
| `player_id` | string (FK) | 플레이어 계정 ID | EAC 탐지 | `player_id` |
| `detected` | boolean | 탐지 여부 | EAC 탐지 | 탐지 여부 |
| `aimbot_lstm` | boolean | Aimbot LSTM 탐지 | EAC 탐지 | 탐지 패턴 |
| `high_crit_rate` | boolean | 높은 치명타율 탐지 | EAC 탐지 | 탐지 패턴 |
| `high_hit_rate` | boolean | 높은 명중률 탐지 | EAC 탐지 | 탐지 패턴 |
| `massive_reports` | integer | 대량 신고 수 | 신고 로그 집계 | `Data_Num1` (대상 유저 신고 받은 횟수) |
| `recursive_massive_reports` | boolean | 재귀적 대량 신고 | EAC 탐지 | 탐지 패턴 |
| `multi_account` | boolean | 동일 기기 다계정 | EAC 탐지 | 탐지 패턴 |
| `hardware_ban` | boolean | 하드웨어 밴 | EAC 탐지 | 탐지 패턴 |
| `dma` | boolean | DMA 탐지 | EAC 탐지 | 탐지 패턴 |
| `details` | text (nullable) | 상세 정보 | EAC 탐지 | 상세 정보 |

---

## 6. NCGuard 탐지 내역 (NCGuard Detection History)

| 필드명 | 데이터 타입 | 설명 | 소스 로그 | 소스 필드 |
|--------|------------|------|----------|----------|
| `match_id` | int64 (FK) | 매치 ID | NCGuard | `Actor_GameOID` |
| `player_id` | string (FK) | 플레이어 계정 ID | NCGuard | `Actor_NPGameAccountID` |
| `detected` | boolean | 탐지 여부 | NCGuard | 탐지 여부 |
| `log_type` | int64 | 로그 타입 / 탐지 타입 | NCGuard | `Entity_ID` |
| `detection_timestamp` | int64 | 탐지 발생 시각 | NCGuard | `Entity_Grade` |
| `detection_data3` | int64 | 탐지 데이터 3 | NCGuard | `Old_Num1` |
| `detection_data4` | int64 | 탐지 데이터 4 | NCGuard | `Old_Num2` |
| `details` | text (nullable) | 상세 정보 | NCGuard | 상세 정보 |

---

## 7. 사내 에임봇 탐지 내역 (Internal Aimbot Detection History)

| 필드명 | 데이터 타입 | 설명 | 소스 로그 | 소스 필드 |
|--------|------------|------|----------|----------|
| `match_id` | int64 (FK) | 매치 ID | NC Aimbot 탐지 | `match_id` |
| `player_id` | string (FK) | 플레이어 계정 ID | NC Aimbot 탐지 | `player_id` |
| `detected` | boolean | 탐지 여부 | NC Aimbot 탐지 | 탐지 여부 |
| `kill_trace_data` | json (nullable) | 킬별 에임 궤적 데이터 | 에임봇 로그 | `yaw`, `pitch` (±30틱 범위) |
| `details` | text (nullable) | 상세 정보 | NC Aimbot 탐지 | 상세 정보 |

---

## 8. 룰기반 탐지 내역 (Rule-based Detection History)

| 필드명 | 데이터 타입 | 설명 | 소스 로그 | 소스 필드 |
|--------|------------|------|----------|----------|
| `match_id` | int64 (FK) | 매치 ID | 룰기반 탐지 | `match_id` |
| `player_id` | string (FK) | 플레이어 계정 ID | 룰기반 탐지 | `player_id` |
| `detected` | boolean | 탐지 여부 | 룰기반 탐지 | 탐지 여부 |
| `respawn_hack` | boolean | 리스폰 핵 | 룰기반 탐지 | 탐지 패턴 |
| `time_energy_hack` | boolean | 타임에너지 핵 | 룰기반 탐지 | 탐지 패턴 |
| `cooldown_ignore_hack` | boolean | 쿨타임 무시 핵 | 룰기반 탐지 | 탐지 패턴 |
| `range_hack` | boolean | 사거리 핵 | 룰기반 탐지 | 탐지 패턴 |
| `movement_hack` | boolean | 이동 핵 | 룰기반 탐지 | 탐지 패턴 |
| `install_hack` | boolean | 설치 핵 | 룰기반 탐지 | 탐지 패턴 |
| `details` | text (nullable) | 상세 정보 | 룰기반 탐지 | 상세 정보 |

---

## 9. 유저 신고 내역 (User Report History)

| 필드명 | 데이터 타입 | 설명 | 소스 로그 | 소스 필드 |
|--------|------------|------|----------|----------|
| `match_id` | int64 (FK) | 매치 ID | ReportPC | `Actor_GameOID` |
| `player_id` | string (FK) | 신고 대상 계정 ID | ReportPC | `Target_GameDBUserNo` (매핑 필요) |
| `reporter_account_id` | string | 신고자 계정 ID | ReportPC | `Actor_NPGameAccountID` |
| `reporter_name` | string | 신고자 유저명 | ReportPC | `Actor_Name` |
| `reason_text` | string | 신고 사유 텍스트 (중복 선택 가능) | ReportPC | `Data_Str1` |
| `report_time` | time | 신고 시간 | ReportPC | `LogTime` |
| `target_reported_count` | int64 | 대상 유저 신고 받은 횟수 | ReportPC | `Data_Num1` |

---

## 참고사항

### 조인 관계

```
에임봇 로그 (시뮬레이션 데이터)
  JOIN 분석 보고서 데이터 테이블
  ON match_id = match_id AND player_id = player_id
```

### 데이터 매핑

- `GameEnd.Actor_GameOID` = `match_id` (int64)
- `GameEnd.Actor_NPGameAccountID` = `player_id` (string)
- `ReportPC.Target_GameDBUserNo` → `player_id` 매핑 필요 (GameDB UserNo와 GameAccountID 매핑 테이블 필요)

### 필드 값 매핑

**게임 타입** (`Actor_GameType`):
- uint16 값 → 게임 타입 문자열 (AI매치/일반매치/이벤트매치/커스텀매치)

**팀 타입** (`Actor_TeamType`):
- uint16 값 → 팀 타입 문자열 (솔로/듀오/트리오/스쿼드)

**OS 정보** (`Actor_OS`):
- int16 값 → OS 문자열 (Unknown/Windows/MacOS/Linux/PS5/XSX)

**캐릭터 ID** (`Actor_Char`):
- 1: 캐시, 2: 버티, 3: 레이븐, 4: 커티스, 5: 에두, 6: 조란, 7: 로쿠로, 8: 안드레이, 9: 아서, 10: 유나, 11: 미사용, 12: 에포크, 13: 앨리스, 14: 자자, 15: 럼&레이진

---

**문서 버전**: 1.0  
**최종 업데이트**: 2025-01-13
