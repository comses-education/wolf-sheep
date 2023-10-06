FROM comses/netlogo:6.3.0

ENV DISPLAY :0

RUN apt-get update \
  && apt-get install -y \
      bash \	
      gconf2 \
      gconf-service \
      gvfs-bin \
      libasound2 \
      libcap2 \
      libgconf-2-4 \
      libgtk2.0-0 \
      libnotify4 \
      libnss3 \
      libxkbfile1 \
      libxss1 \
      libxtst6 \
      libx11-xcb-dev \
      xdg-utils \
      --no-install-recommends \
  && rm -rf /var/lib/apt/lists/*

CMD ["/opt/netlogo/netlogo-headless.sh", "--model", "/code/src/wolf-sheep-predation.nlogo"]
