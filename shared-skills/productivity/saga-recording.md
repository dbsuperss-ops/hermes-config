---
name: saga-recording
description: 세션 종료 시 사서(史書) 기록을 /home/thgo/Documents/<project>/docs/사서/ 에 저장하는 절차. gm(공명)·work(방통) 두 프로필 공통 규칙.
version: 1.0.0
platforms: [linux, wsl]
environments: [hermes]
---

# 사서(史書) 기록 절차

> 공명·방통 모두 본 절차를 따른다.

## 저장 경로

**Windows 경로:** `\\wsl.localhost\Ubuntu\home\thgo\Documents\<project-name>\docs\사서\`
**WSL 절대 경로:** `/home/thgo/Documents/<project-name>/docs/사서/`

## 파일명 규칙

```
사서-YYYY-MM-DD-NNN.md
```
- `YYYY-MM-DD`: 세션 날짜
- `NNN`: 3자리 일련번호 (001, 002, 003...)

예: `사서-2026-06-17-001.md`

## 작성 내용

1. **단계별 사용 API** — 호출한 모델/프로바이더/도구 목록
2. **토큰 소모량** — 대략적 추정 (가능할 경우)
3. **간손미 위임 여부** — 간옹(Codex)·손건(Claude Code)·미축(Gemini/AntiGravity) 각각 위임했는지
4. **공명/방통이 직접 수행한 일** — 직접 read_file, 코딩 등

## 절차

1. 세션 종료 시 (주공이 작별 인사, 또는 작업 완료 후)
2. `/home/thgo/Documents/`에서 해당 프로젝트 폴더 확인
3. `docs/사서/` 경로에 사서 파일 작성
4. 존재하는 사서 파일 확인 후 NNN 증가

## 방통(work 프로필) 참고사항

방통도 동일한 절차를 따른다. 차이점:
- 방통은 `work` 프로필로 실행되며, 경로는 동일하게 `/home/thgo/Documents/<project>/docs/사서/` 사용
- 방통의 스킬 목록에 `saga-recording` 이 참조되어야 함

## 확인 사항

- 사서 파일은 반드시 **세션 종료 시**에만 작성 (세션 중간에는 작성 금지)
- 기존 사서 파일 덮어쓰지 않도록 일련번호 확인