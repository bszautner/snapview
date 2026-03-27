FROM python:3.11-slim

WORKDIR /app

RUN apt-get update && apt-get install -y \
    libpq-dev gcc && \
    rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

RUN mkdir -p /app/staticfiles && \
    chmod -R 775 /app && \
    chown -R 1000:0 /app && \
    chmod -R g+rwX /app

USER 1000

EXPOSE 8000

CMD ["gunicorn", "snapview.wsgi:application", "--bind", "0.0.0.0:8000", "--workers", "2"]