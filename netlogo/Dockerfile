FROM phusion/baseimage:0.11 as netlogo_download

ARG NETLOGO_VERSION=6.0.4

RUN apt-get update && apt-get install -y python3-pip && rm -rf /var/lib/apt/lists/*
RUN pip3 install httpie

RUN mkdir /netlogo \ 
  && http --download http://ccl.northwestern.edu/netlogo/${NETLOGO_VERSION}/NetLogo-${NETLOGO_VERSION}-64.tgz > netlogo.tgz \
  && tar xf netlogo.tgz -C /netlogo --strip-components=1 \
  && rm netlogo.tgz

COPY netlogo.sh /netlogo

# Final build
FROM phusion/baseimage:0.11

ENV DISPLAY :0

RUN apt-get update \
  && apt-get install -y \
      bash \	
      openjdk-8-jre \
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
COPY --from=netlogo_download /netlogo /netlogo

CMD ["/netlogo/netlogo.sh", "--model", "/code/src/wolf-sheep-predation.nlogo"]
