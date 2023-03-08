FROM ubuntu:latest

# env variables
ENV RUNNER_ID="PLACEHOLDER_TOKEN"
ENV RUNNER_SECRET="PLACEHOLDER_TOKEN"
ENV RUNNER_PDTOKEN="PLACEHOLDER_TOKEN"

# get the essentials
RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install -y apt-utils
RUN apt-get install -y curl 
RUN apt-get install -y wget
RUN apt-get install -y less
RUN apt-get install -y vim

# install nodejs/npm
RUN curl -sL https://deb.nodesource.com/setup_16.x -o /tmp/nodesource_setup.sh
RUN sh /tmp/nodesource_setup.sh
RUN rm -rf /tmp/nodesource_setup.sh
RUN apt-get install -y nodejs

# install java
RUN apt-get install -y openjdk-11-jre-headless

# create automation_runner directory
RUN mkdir -p /opt/automation_runner
WORKDIR /opt/automation_runner

# install runner
RUN wget https://runbook-actions.pagerduty.com/pd-runner.jar

# install pagerduty-cli
RUN npm install -g pagerduty-cli
ENTRYPOINT echo ${RUNNER_PDTOKEN} | pd auth:set && java -jar pd-runner.jar && /bin/bash