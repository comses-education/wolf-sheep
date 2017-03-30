FROM chenjr0719/ubuntu-mate-novnc

RUN apt-get update && \
  apt-get install -y httpie openjdk-8-jre && \
  apt-get autoclean && \
  apt-get autoremove && \
  rm -rf /var/lib/apt/lists/*

##### Add NetLogo
RUN mkdir /netlogo \ 
  && http --download http://ccl.northwestern.edu/netlogo/5.3.1/NetLogo-5.3.1-64.tgz > netlogo.tgz \
  && tar xf netlogo.tgz -C /netlogo --strip-components=1 \
  && rm netlogo.tgz

COPY netlogo-headless.sh /netlogo/app/netlogo-headless.sh

