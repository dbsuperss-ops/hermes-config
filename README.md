# Hermes Agent Configuration — gm profile

이 저장소는 Hermes AI Agent의 `gm`(공명/방통) 프로필 구성 파일과 아키텍처 문서를 관리합니다.

## 구조

```
hermes-config/
├── README.md
├── Hermes_최종_구축계획_2026-06.md   # 전체 구축 계획 문서
├── hermes-agent-architecture-v3.html # 아키텍처 다이어그램 (브라우저 열람)
└── gm/
    ├── config.yaml                    # Hermes 설정 (684줄)
    ├── SOUL.md                        # 인격 정의 + 지휘관 원칙
    └── or-balance.py                  # OpenRouter 잔액 리포트 스크립트
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

- **공명 (워크)**: 제갈량 — 격식체, 전략적, 코딩/업무
- **방통 (홈)**: 봉추 — 구어체, 익살, 일상/잡담

두 인격은 공유 뇌(MEMORY.md, USER.md, Skills 80+개)를 사용하며, SOUL.md는 [고정 prefix] + [persona delta] 구조로 캐시 최적화되어 있습니다.

## CCG 교차검증

이 설정은 Claude Code + Codex + Gemini CLI 3개 도구의 교차검증을 거쳤습니다.