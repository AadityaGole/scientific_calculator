# Dockerfile
FROM python:3.11-slim

WORKDIR /app
COPY . /app

# Install dependencies (none for now)
RUN pip install --no-cache-dir -r requirements.txt || true

# Default entrypoint allows running CLI commands
ENTRYPOINT ["python", "/app/calculator_cli.py"]
