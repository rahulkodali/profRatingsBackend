# Professor Review Aggregation Backend

## Description

This is the backend service for a professor review aggregation application. The backend scrapes professor reviews from RateMyProfessors.com using Playwright and processes them to provide a detailed analysis, including pros, cons, and an overall rating summary using Google’s Generative AI. The service is built with Flask and is optimized for deployment using Gunicorn with Gevent workers.

## Features

- **Scraping:** Utilizes Playwright for headless browser automation to scrape professor reviews.
- **AI-Powered Summaries:** Integrates Google’s Gemini AI to generate comprehensive summaries of collected reviews.
- **Async Processing:** Asynchronous tasks and scraping operations using Python’s `asyncio` and `nest_asyncio`.
- **Logging:** Comprehensive logging for monitoring and debugging.
- **CORS Enabled:** CORS support for seamless API integration with the frontend.
- **Deployment-Ready:** Optimized for deployment with Gunicorn and Gevent for handling high concurrency on platforms like Render.
