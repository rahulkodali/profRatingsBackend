# Use an official Python runtime as a parent image
FROM python:3.11-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Install necessary system dependencies
RUN apt-get update && apt-get install -y \
    libicu66 \
    libevent-2.1-7 \
    libjpeg62-turbo \
    libenchant-2-2 \
    libsecret-1-0 \
    libffi7 \
    libgles2-mesa \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app/

# Install Python dependencies and Playwright browsers
RUN pip install --no-cache-dir -r requirements.txt && playwright install --with-deps

# Expose the port that your application will run on
EXPOSE 10000

# Run the application
CMD ["gunicorn", "main:app", "-b", "0.0.0.0:10000", "--workers", "4"]
