FROM python:3.10-slim

# 1. Install vanilla system headless Chromium, Driver, and base utilities
RUN apt-get update && apt-get install -y --no-install-recommends \
    chromium \
    chromium-driver \
    ca-certificates \
    curl \
    wget \
    fonts-liberation \
    libappindicator3-1 \
    libasound2 \
    libatk-bridge2.0-0 \
    libatk1.0-0 \
    libc6 \
    libcairo2 \
    libcups2 \
    libdbus-1-3 \
    libexpat1 \
    libfontconfig1 \
    libgbm1 \
    libgcc1 \
    libgdk-pixbuf2.0-0 \
    libglib2.0-0 \
    libgtk-3-0 \
    libnspr4 \
    libnss3 \
    libpango-1.0-0 \
    libpangocairo-1.0-0 \
    libstdc++6 \
    libx11-6 \
    libx11-xcb1 \
    libxcb1 \
    libxcomposite1 \
    libxcursor1 \
    libxdamage1 \
    libxext6 \
    libxfixes3 \
    libxi6 \
    libxrandr2 \
    libxrender1 \
    libxss1 \
    libxtst6 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# 2. Set runtime environment properties
ENV PYTHONUNBUFFERED=1
WORKDIR /app

# 3. Pull code directly from repository context layer
COPY . /app

# 4. Hard-harden local execute flags for your compiled Go binary
RUN chmod +x ./google-maps-scraper

# 5. Install light Python pipeline dependencies
RUN pip install --no-cache-dir requests supabase dnspython

# 6. Fire the automated MSA master tracking engine
CMD ["python", "healthcare_scout.py"]
