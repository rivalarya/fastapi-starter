FROM python:3.14-alpine@sha256:5a824eb82cc75361f98611f3cfc5091ea33f10a6ccea4d4ebdabbc523b9a1614 AS builder
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

FROM python:3.14-alpine@sha256:5a824eb82cc75361f98611f3cfc5091ea33f10a6ccea4d4ebdabbc523b9a1614 AS runner
WORKDIR /app
ENV APP_ENV=production

RUN addgroup --system --gid 1001 fastapi-starter \
 && adduser --system --uid 1001 appuser \
 && chown -R appuser:fastapi-starter /app

COPY --chown=appuser:fastapi-starter --from=builder /usr/local/lib/python3.12 /usr/local/lib/python3.12
COPY --chown=appuser:fastapi-starter --from=builder /usr/local/bin /usr/local/bin
COPY --chown=appuser:fastapi-starter . .

USER appuser
EXPOSE 4000
ENV PORT=4000

CMD ["python", "-m", "uvicorn", "src.main:app", "--host", "0.0.0.0", "--port", "4000"]