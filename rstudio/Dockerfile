FROM rocker/rstudio:3.3.3

#RUN apt-get update && \
#  apt-get install -y httpie openjdk-8-jre && \
#  rm -rf /var/lib/apt/

# Install R Packages
COPY . /home/rstudio/code 
RUN cd /home/rstudio/code && R --vanilla --slave -f .Rprofile --args --bootstrap-packrat
RUN chown -R 1000:1000 /home/rstudio

WORKDIR /home/rstudio/code
