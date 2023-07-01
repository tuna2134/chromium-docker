FROM debian AS installer

WORKDIR /src/installer

RUN apt-get update && apt-get install -y wget unzip
RUN wget https://commondatastorage.googleapis.com/chromium-browser-snapshots/Linux_x64/1165082/chrome-linux.zip && \
  unzip chrome-linux.zip

FROM debian

WORKDIR /src/app

RUN apt-get update
RUN apt-get install -y libglib2.0-0 libnss3 \
  libatk1.0-0 libatk-bridge2.0-0 libcups2 \
  libdrm2 libxkbcommon-dev libxcomposite1 \
  libxdamage1 libxfixes3 libxrandr2 libgbm1 \
  libpango-1.0-0 libcairo2 libasound2 \
  task-japanese fonts-ipafont fonts-ipaexfont
RUN fc-cache -fv

COPY --from=installer /src/installer/chrome-linux/* .
ENTRYPOINT ["./chrome"]

EXPOSE 9222
CMD ["--remote-debugging-port=9222", "--remote-debugging-address=0.0.0.0"]
