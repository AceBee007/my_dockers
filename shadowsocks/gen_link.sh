#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

if [ ! -f .env ]; then
  echo "Error: .env not found. Run 'cp .env.sample .env' first." >&2
  exit 1
fi

set -a && source .env && set +a
exec python3 generate_ss_link.py
