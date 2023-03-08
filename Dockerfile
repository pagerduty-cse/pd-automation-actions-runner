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

# install python & pip
RUN apt-get install -y software-properties-common
RUN add-apt-repository -y ppa:deadsnakes/ppa
RUN apt-get install -y python3.10
RUN rm /usr/bin/python3
RUN ln -s /usr/bin/python3.10 /usr/bin/python3
RUN ln -s /usr/bin/python3.10 /usr/bin/python
RUN apt-get install -y python3-pip

# install java
RUN apt-get install -y openjdk-11-jre-headless

# create directory and make pdrunner-creds file
RUN mkdir -p /opt/automation_runner
WORKDIR /opt/automation_runner
RUN touch pdrunner-creds
RUN echo "id:${RUNNER_ID}" > pdrunner-creds
RUN echo "secret:${RUNNER_SECRET}" > pdrunner-creds
RUN echo "token:${RUNNER_PDTOKEN}" > pdrunner-creds

# install runner
RUN wget https://runbook-actions.pagerduty.com/pd-runner.jar

# install pagerduty-cli
RUN npm install -g pagerduty-cli
ENTRYPOINT echo ${RUNNER_PDTOKEN} | pd auth:set && java -jar pd-runner.jar && /bin/bash