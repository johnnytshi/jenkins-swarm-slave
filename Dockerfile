FROM openjdk:8-jdk

USER root

RUN apt-get update
RUN apt-get install -y --no-install-recommends curl docker git mercurial iptables php php-curl
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -
RUN apt-get -y install nodejs
RUN npm install -g n
RUN n 6.9.2

RUN mkdir /workspace && \
	chmod 777 /workspace

RUN curl -O https://repo.jenkins-ci.org/releases/org/jenkins-ci/plugins/swarm-client/3.3/swarm-client-3.3.jar

RUN git clone https://github.com/phacility/libphutil.git /root/libphutil
RUN git clone https://github.com/phacility/arcanist.git /root/arcanist
ENV PATH "/root/arcanist/bin:${PATH}"

CMD echo "{\"hosts\": {\"$PHAB_HOST\": {\"token\": \"$PHAB_TOKEN\"}}}" > /root/.arcrc \
	&& chmod 600 /root/.arcrc \
	&& java \
  -jar \
  /swarm-client-3.3.jar \
  -master $MASTER \
  -username $USER \
  -password $PASSWORD \
  -executors 1
