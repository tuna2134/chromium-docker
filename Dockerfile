FROM debian

WORKDIR /src/app

RUN apt-get update && apt-get install wget unzip
RUN wget https://commondatastorage.googleapis.com/chromium-browser-snapshots/Linux_x64/1164491/chrome-linux.zip && \
  unzip chrome-linux.zip

WORKDIR /src/app/chrome-linux

CMD ["./chrome"]
