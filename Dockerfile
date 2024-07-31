FROM python:3.11-slim

# Install system dependencies for Playwright
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        libnss3 \
        libnspr4 \
        libdbus-1-3 \
        libatk1.0-0 \
        libatk-bridge2.0-0 \
        libcups2 \
        libatspi2.0-0 \
        libxcomposite1 \
        libxdamage1 \
        libxrandr2 \
        libxkbcommon0 \
        libpango-1.0-0 \
        libcairo2 \
        libasound2 \
        curl \
        wget \
        unzip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /app

# Install Python dependencies
COPY requirements.txt /app/
RUN pip install --no-cache-dir -r requirements.txt && \
    python -m playwright install && \
    python -m playwright install-deps

# Copy the rest of the application code
COPY . /app

# Expose the port
EXPOSE 5001

# Set a non-root user (optional but recommended for security)
RUN useradd -m appuser && chown -R appuser /app
USER appuser

# Run the application
CMD ["gunicorn", "--bind", "0.0.0.0:5001", "main:app"]
