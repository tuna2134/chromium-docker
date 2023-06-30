FROM debian

WORKDIR /src/app

RUN apt-get update && apt-get install -y wget unzip
RUN wget https://commondatastorage.googleapis.com/chromium-browser-snapshots/Linux_x64/1164491/chrome-linux.zip && \
  unzip chrome-linux.zip

RUN apt-get install -y libglib2.0-0 libnss3 \
  libatk1.0-0 libatk-bridge2.0-0 libcups2 \
  libdrm2 libxkbcommon-dev libxcomposite1 \
  libxdamage1 libxfixes3 libxrandr2 libgbm1 \
  libpango-1.0-0 libcairo2

WORKDIR /src/app/chrome-linux

CMD ["./chrome"]
