# Simple Notes App (monorepo scaffold)

This repository is the **scaffolding and wiring** for a Simple Notes App consisting of:

- `notes_backend/` (FastAPI): REST API for note CRUD
- `notes_frontend/` (React): UI for notes list + editor
- `database/` (SQLite): persisted storage (single file DB)

> Note: In this code-generation workspace, these containers may also exist as sibling folders.
> The intended end-state is a single repo containing the three directories above.

## Quick start (local)

### 1) Database (SQLite container)
The database container stores data in `database/myapp.db`.

- Connection info is documented in: `database/db_connection.txt`
- Initialize DB (idempotent):
  ```bash
  cd database
  python3 init_db.py
  ```

### 2) Backend (FastAPI)
```bash
cd notes_backend
python3 -m venv .venv
. .venv/bin/activate
pip install -r requirements.txt
uvicorn src.api.main:app --host 0.0.0.0 --port 3001
```

### 3) Frontend (React)
```bash
cd notes_frontend
npm install
npm start
```

## Environment variables
Each container has its own `.env`. See `*.env.example` files for documented variables.

## CI (lightweight)
A lightweight script is provided at `scripts/ci.sh` to run formatting/lint/test steps for backend and frontend builds.

Task completed: Repo scaffolding documentation + initial wiring instructions added.