#!/usr/bin/env bash
set -euo pipefail

# Convenience dev script to run all containers locally.
# Starts backend and frontend; initializes DB first (idempotent).
#
# NOTE: This script assumes a monorepo layout:
#   - database/
#   - notes_backend/
#   - notes_frontend/

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "==> Initializing SQLite database (idempotent)"
pushd "${ROOT_DIR}/database" >/dev/null
python3 init_db.py
popd >/dev/null

echo "==> Starting backend on :3001"
pushd "${ROOT_DIR}/notes_backend" >/dev/null
python3 -m pip install --upgrade pip >/dev/null
pip install -r requirements.txt >/dev/null
nohup uvicorn src.api.main:app --host 0.0.0.0 --port 3001 > "${ROOT_DIR}/.backend.log" 2>&1 &
echo "backend pid: $!"
popd >/dev/null

echo "==> Starting frontend on :3000"
pushd "${ROOT_DIR}/notes_frontend" >/dev/null
npm install
nohup npm start > "${ROOT_DIR}/.frontend.log" 2>&1 &
echo "frontend pid: $!"
popd >/dev/null

echo "==> Logs:"
echo "  backend:  ${ROOT_DIR}/.backend.log"
echo "  frontend: ${ROOT_DIR}/.frontend.log"
echo
echo "==> Open:"
echo "  http://localhost:3000"
