#!/usr/bin/env bash
# ──────────────────────────────────────────────────────────
# Hermes Config & Skill Deployer
# Usage: bash deploy.sh [profile_name]
#   profile_name: gm (공명) or bt (방통) — default: all
#
# 다른 PC에서 이 저장소를 클론한 후 실행하면
# SOUL.md, config.yaml을 ~/.hermes/profiles/ 에 배포한다.
# ──────────────────────────────────────────────────────────
set -euo pipefail

HERMES_BASE="${HOME}/.hermes/profiles"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

deploy_profile() {
    local name="$1"
    local target="${HERMES_BASE}/${name}"
    
    echo "==> Deploying '${name}' profile..."
    
    # SOUL.md
    if [ -f "${SCRIPT_DIR}/${name}/SOUL.md" ]; then
        mkdir -p "${target}"
        cp "${SCRIPT_DIR}/${name}/SOUL.md" "${target}/SOUL.md"
        echo "    ✓ SOUL.md deployed"
    fi
    
    # config.yaml
    if [ -f "${SCRIPT_DIR}/${name}/config.yaml" ]; then
        mkdir -p "${target}"
        cp "${SCRIPT_DIR}/${name}/config.yaml" "${target}/config.yaml"
        echo "    ✓ config.yaml deployed"
    fi
    
    # Shared skills
    if [ -d "${SCRIPT_DIR}/shared-skills" ]; then
        local SKILLS_TARGET="${target}/skills"
        mkdir -p "${SKILLS_TARGET}"
        while IFS= read -r -d '' skill_file; do
            local rel_path="${skill_file#${SCRIPT_DIR}/shared-skills/}"
            local skill_dir="${SKILLS_TARGET}/$(dirname "${rel_path}")"
            local skill_name="$(basename "${rel_path}" .md)"
            mkdir -p "${skill_dir}/${skill_name}"
            cp "${skill_file}" "${skill_dir}/${skill_name}/SKILL.md"
            echo "    ✓ skill: ${rel_path} → ${skill_name}"
        done < <(find "${SCRIPT_DIR}/shared-skills" -name '*.md' -print0 2>/dev/null)
    fi
}

# ── 사서 저장소 디렉토리 생성 ─────────────────────────────
create_saga_dirs() {
    local projects=("SummitClosure_co" "Cockpit" "NOBIMAKER" "SlideMark" "kyungshin-digital-lego" "omc-agent")
    echo "==> Creating saga (사서) storage directories..."
    for project in "${projects[@]}"; do
        local dir="${HOME}/Documents/${project}/docs/사서"
        if [ ! -d "${dir}" ]; then
            mkdir -p "${dir}"
            echo "    ✓ ${dir}"
        else
            echo "    - ${dir} (exists)"
        fi
    done
}

# ── Main ──────────────────────────────────────────────────
if [ $# -eq 0 ]; then
    deploy_profile "gm"
    deploy_profile "bt"
    create_saga_dirs
    echo "==> All profiles deployed."
elif [ "$1" = "saga-dirs" ]; then
    create_saga_dirs
else
    deploy_profile "$1"
fi

echo "==> Done."