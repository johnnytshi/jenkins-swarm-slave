FROM library/ubuntu:17.04

RUN apt-get update
RUN apt-get -y install curl
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -
RUN apt-get -y install -y nodejs
RUN npm install -g n
RUN n 6.9.2
