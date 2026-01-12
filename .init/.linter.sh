#!/bin/bash
set -euo pipefail

cd /home/kavia/workspace/code-generation/simple-notes-application-51884-51899/notes_backend

# Ensure a venv exists for linting in non-interactive CI environments.
if [ ! -d ".venv" ]; then
  python3 -m venv .venv
fi

# shellcheck disable=SC1091
source .venv/bin/activate

python3 -m pip install --upgrade pip >/dev/null
pip install -r requirements.txt >/dev/null

flake8 .

