FROM python:3.11-slim

# Install necessary system dependencies
RUN apt-get update && apt-get install -y \
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
    libdrm2 \                         
    libxfixes3 \                                  
    libgbm1  \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install Playwright and its dependencies
RUN pip install playwright
RUN playwright install
RUN playwright install-deps

# Install other Python dependencies
COPY requirements.txt .
RUN pip install -r requirements.txt

# Copy the application code
COPY . /app
WORKDIR /app

# Expose the port Flask will run on
EXPOSE 5001

# Command to run the application
CMD ["gunicorn", "--worker-class=gevent", "--worker-connections=200", "--workers=4", "-b", "0.0.0.0:5001", "main:app"]

