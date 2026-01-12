import os

from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

openapi_tags = [
    {"name": "Health", "description": "Service health and diagnostics."},
]

app = FastAPI(
    title="Simple Notes API",
    description="Backend API for the Simple Notes App (scaffold).",
    version="0.1.0",
    openapi_tags=openapi_tags,
)

# Configure CORS from env when available, otherwise default permissive for scaffolding.
allowed_origins_env = os.getenv("ALLOWED_ORIGINS", "*")
allow_origins = (
    ["*"]
    if allowed_origins_env.strip() == "*"
    else [o.strip() for o in allowed_origins_env.split(",") if o.strip()]
)

app.add_middleware(
    CORSMiddleware,
    allow_origins=allow_origins,
    allow_credentials=True,
    allow_methods=[m.strip() for m in os.getenv("ALLOWED_METHODS", "*").split(",")],
    allow_headers=[h.strip() for h in os.getenv("ALLOWED_HEADERS", "*").split(",")],
)

# Scaffolding wiring: backend will use this path when implementing note persistence.
SQLITE_DB_PATH = os.getenv("SQLITE_DB_PATH", "../database/myapp.db")


@app.get("/", tags=["Health"], summary="Health check")
# PUBLIC_INTERFACE
def health_check():
    """Health check endpoint.

    Returns:
        dict: Simple payload indicating service is up.
    """
    return {"message": "Healthy", "sqlite_db_path": SQLITE_DB_PATH}
