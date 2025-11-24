FROM python:3.9-slim

# Remove pip root warning (safe for Docker on EC2)
ENV PIP_ROOT_USER_ACTION=ignore

# Create app directory
WORKDIR /app

# Install packages required for mysqlclient
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        gcc \
        default-libmysqlclient-dev \
        pkg-config \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements first (takes advantage of Docker caching)
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY . .

# Start the app
CMD ["python", "app.py"]
