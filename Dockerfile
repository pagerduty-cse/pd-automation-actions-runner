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

# install java
RUN apt-get install -y openjdk-11-jre-headless

# install automation_runner
RUN mkdir -p /opt/automation_runner
WORKDIR /opt/automation_runner
RUN wget https://runbook-actions.pagerduty.com/pd-runner.jar
RUN dpkg --add-architecture arm64

# install pagerduty-cli
# RUN sh -c "$(curl -sL https://raw.githubusercontent.com/martindstone/pagerduty-cli/master/install.sh)"
RUN curl -sL https://raw.githubusercontent.com/martindstone/pagerduty-cli/master/install.sh -o /tmp/install.sh
RUN sh /tmp/install.sh
RUN rm -rf /tmp/install.sh

# entrypoint
ENTRYPOINT echo ${RUNNER_PDTOKEN} | pd auth:set && java -jar pd-runner.jar && /bin/bash

# ENTRYPOINT java -jar pd-runner.jar && /bin/bash