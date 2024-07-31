FROM python:3.11-slim

# Install system dependencies
RUN apt-get update && \
    apt-get install -y \
        libicu-dev \
        libevent-dev \
        libjpeg62-turbo \
        libenchant-2-2 \
        libsecret-1-0 \
        libffi-dev \
        libgles2-mesa-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt && playwright install

# Copy the rest of the application code
COPY . .

# Command to run your application
CMD ["python", "main.py"]
