#!/usr/bin/env bash
set -euo pipefail

# Lightweight CI script for the monorepo scaffold.
# Non-interactive by design (suitable for CI runners).

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "==> CI: backend (lint + tests)"
if [[ -d "${ROOT_DIR}/notes_backend" ]]; then
  pushd "${ROOT_DIR}/notes_backend" >/dev/null
  python3 -m pip install --upgrade pip >/dev/null
  pip install -r requirements.txt >/dev/null
  # flake8 config is container-local
  flake8 .
  pytest -q
  popd >/dev/null
else
  echo "notes_backend not found; skipping."
fi

echo "==> CI: frontend (build)"
if [[ -d "${ROOT_DIR}/notes_frontend" ]]; then
  pushd "${ROOT_DIR}/notes_frontend" >/dev/null
  npm ci
  CI=true npm run build
  popd >/dev/null
else
  echo "notes_frontend not found; skipping."
fi

echo "==> CI: done"
