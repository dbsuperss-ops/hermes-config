# Hermes Agent Configuration

이 저장소는 Hermes AI Agent의 `gm`(공명) 및 `bt`(방통) 프로필 구성 파일과 아키텍처 문서를 관리합니다.

## 구조

```
hermes-config/
├── README.md
├── deploy.sh                          # 프로필 배포 스크립트 (다른 PC에서 실행)
├── Hermes_최종_구축계획_2026-06.md   # 전체 구축 계획 문서
├── hermes-agent-architecture-v3.html  # 아키텍처 다이어그램 (브라우저 열람)
├── shared-skills/                     # 공용 스킬 (양 프로필에 배포)
│   └── productivity/
│       └── saga-recording.md          # 사서 기록 절차
├── gm/                                # 공명 (Gongmyeong) 프로필
│   ├── config.yaml                    # Hermes 설정 (공명용)
│   ├── SOUL.md                        # 인격 정의 + 지휘관 원칙 (공명용)
│   └── or-balance.py                  # OpenRouter 잔액 리포트 스크립트
└── bt/                                # 방통 (Bangtong) 프로필
    ├── config.yaml                    # Hermes 설정 (방통용)
    ├── SOUL.md                        # 인격 정의 + 참모 원칙 (방통용)
    └── or-balance.py                  # OpenRouter 잔액 리포트 스크립트 (bt용)
```

## 주요 설정 (v3 — 2026-06-16)

| 항목 | 값 |
|---|---|
| **지휘관 모델** | `deepseek/deepseek-v4-pro` (가성비 50.6) |
| **방통 모델** | `deepseek/deepseek-v4-flash` (가성비 204) |
| **복잡 검증** | `google/gemini-3.5-flash` (선택적 fallback) |
| **max_turns** | 100 |
| **Data Collection** | deny |
| **Ignore** | `OpenRouter:free`, `owl-alpha` |
| **Fallback** | flash → pro |
| **월 비용 cap** | $10 |

## 이중 인격

현재 두 개의 분리된 프로필로 운영됩니다. 각 프로필은 공유 뇌(MEMORY.md, USER.md, Skills 80+개)를 사용하며, SOUL.md는 [고정 prefix] + [persona delta] 구조로 캐시 최적화되어 있습니다.

- **gm (공명)**: 제갈량 — 격식체, 전략적, 코딩/업무 (전용 config.yaml 및 SOUL.md 사용)
- **bt (방통)**: 봉추 — 구어체, 익살, 일상/잡담 (전용 config.yaml 및 SOUL.md 사용)

## 적극 개입형 지휘 원칙

공명·방통은 순수 위임자에 머물지 않고, 의도 파악·구조 분석·경량 조사·필요한 도구 실행·결과 검증에 직접 개입합니다. 다만 대규모 구현, 리팩터링, 장시간 테스트, 위험 변경은 간(肝)=Codex, 손(孫)=Claude Code, 미(米)=AntiGravity에 위임하고 지휘관이 검증·취합합니다.

## CCG 교차검증

이 설정은 Claude Code + Codex + Gemini CLI 3개 도구의 교차검증을 거쳤습니다.

## 사서(史書) 기록 규칙

공명과 방통은 세션 종료 시마다 **사서(史書)** 파일을 기록합니다.

| 항목 | 내용 |
|------|------|
| **저장 경로** | `/home/thgo/Documents/<프로젝트명>/docs/사서/` |
| **Windows 경로** | `\\wsl.localhost\Ubuntu\home\thgo\Documents\<프로젝트명>\docs\사서\` |
| **파일명 형식** | `사서-YYYY-MM-DD-NNN.md` |
| **기록 내용** | (1) 사용 API (2) 토큰 소모량 (3) 간손미 위임 (4) 직접 수행한 일 |

### 다른 PC에서 초기 설정

```bash
# 1. 저장소 클론
git clone git@github.com:dbsuperss-ops/hermes-config.git ~/hermes-config

# 2. 모든 프로필 배포
bash ~/hermes-config/deploy.sh

# 3. 배포 후 Hermes 재시작
hermes
```

`deploy.sh`가 SOUL.md, config.yaml, shared-skills를 `~/.hermes/profiles/`로 복사하고 사서 저장소 디렉토리를 생성합니다.
