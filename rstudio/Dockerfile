FROM rocker/rstudio:3.3.3

# Install R Packages
COPY . /home/rstudio/code 
RUN cd /home/rstudio/code && R --vanilla --slave -f .Rprofile --args --bootstrap-packrat
RUN chown -R 1000:1000 /home/rstudio

WORKDIR /home/rstudio/code
