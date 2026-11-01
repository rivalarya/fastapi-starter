FROM python:3.15-slim@sha256:94d3426f1def7db4a106a232ac121bfd975393e5dfd40a619b955fae45fe7913 AS builder
WORKDIR /app
COPY pyproject.toml .
RUN pip install --no-cache-dir .

FROM python:3.15-slim@sha256:94d3426f1def7db4a106a232ac121bfd975393e5dfd40a619b955fae45fe7913 AS runner
WORKDIR /app
ENV APP_ENV=production

RUN addgroup --system --gid 1001 fastapi-starter \
    && adduser --system --uid 1001 appuser \
    && chown -R appuser:fastapi-starter /app
COPY --chown=appuser:fastapi-starter --from=builder /usr/local/lib/python3.13 /usr/local/lib/python3.13
COPY --chown=appuser:fastapi-starter --from=builder /usr/local/bin /usr/local/bin
COPY --chown=appuser:fastapi-starter . .

USER appuser
EXPOSE 4000
ENV PORT=4000

CMD ["python", "-m", "uvicorn", "src.main:app", "--host", "0.0.0.0", "--port", "4000"]