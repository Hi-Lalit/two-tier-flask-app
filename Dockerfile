FROM python:3.9-slim

# Prevent debconf errors (dialog/readline issues)
ENV DEBIAN_FRONTEND=noninteractive

# Remove pip root warning
ENV PIP_ROOT_USER_ACTION=ignore

WORKDIR /app

# Install system dependencies
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        gcc \
        default-libmysqlclient-dev \
        pkg-config \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

CMD ["python", "app.py"]
