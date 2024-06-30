FROM debian:bookworm-slim AS installer

WORKDIR /src/installer

RUN apt-get update && apt-get install -y wget unzip
RUN wget --trust-server-names https://download-chromium.appspot.com/dl/Linux_x64?type=snapshots && \
  unzip chrome-linux.zip

FROM debian:bookworm-slim

WORKDIR /src/app

RUN apt-get update
RUN apt-get install -y libglib2.0-0 libnss3 \
  libatk1.0-0 libatk-bridge2.0-0 libcups2 \
  libdrm2 libxkbcommon-dev libxcomposite1 \
  libxdamage1 libxfixes3 libxrandr2 libgbm1 \
  libpango-1.0-0 libcairo2 libasound2 \
  task-japanese fonts-ipafont fonts-ipaexfont \
  locales

RUN sed -i -E 's/# (ja_JP.UTF-8)/\1/' /etc/locale.gen
RUN locale-gen ja_JP.UTF-8

# Set environment variables.
ENV LANG ja_JP.UTF-8
RUN fc-cache -fv

RUN adduser chrome
COPY --from=installer --chown=chrome:chrome /src/installer/chrome-linux/* .
USER chrome
ENTRYPOINT ["./chrome"]

EXPOSE 9222
CMD ["--remote-debugging-port=9222", "--remote-debugging-address=0.0.0.0"]
