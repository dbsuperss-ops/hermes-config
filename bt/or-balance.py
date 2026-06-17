#!/usr/bin/env python3
"""Hermes OpenRouter Balance Script — daily Telegram delivery (bt profile)"""
import json
import os
import sys

# Source .env from bt profile
env_path = os.path.expanduser("~/.hermes/profiles/bt/.env")
if os.path.exists(env_path):
    with open(env_path) as f:
        for line in f:
            line = line.strip()
            if line and not line.startswith("#") and "=" in line:
                k, v = line.split("=", 1)
                os.environ[k] = v

api_key = os.environ.get("OPENROUTER_API_KEY", "")
if not api_key:
    print("OpenRouter balance check failed: no API key")
    sys.exit(0)

import urllib.request

req = urllib.request.Request(
    "https://openrouter.ai/api/v1/credits",
    headers={"Authorization": f"Bearer {api_key}"},
)
try:
    with urllib.request.urlopen(req, timeout=10) as resp:
        data = json.loads(resp.read())["data"]
except Exception as e:
    print(f"OpenRouter balance check failed: {e}")
    sys.exit(0)

total = data["total_credits"]
usage = data["total_usage"]
remain = total - usage
pct = int(usage / total * 100) if total > 0 else 0

print("📊 OpenRouter Budget Report")
print(f"월 한도: ${total}")
print(f"사용:    ${usage:.2f} ({pct}%)")
print(f"잔여:   ${remain:.2f}")

if remain < 3:
    print()
    print("⚠️  주의: 잔여 예산이 $3 미만입니다. Claude Code 위임을 우선하세요.")