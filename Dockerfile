FROM ubuntu:latest

# env variables
ENV RUNNER_ID=""
ENV RUNNER_SECRET=""
ENV RUNNER_PDTOKEN=""
ENV RUNNER_CLOUD_RDKCLIENT_URL=""
ENV RUNNER_CLOUD_RDKCLIENT_TOKEN=""

# get the essentials
RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install -y apt-utils
RUN apt-get install -y curl 
RUN apt-get install -y wget

# install java
RUN apt-get install -y openjdk-11-jre-headless

# create automation_runner directory
RUN mkdir -p /opt/automation_runner
WORKDIR /opt/automation_runner

# entrypoint (install pagerduty-cli, install automation_runner, set pdtoken, run automation_runner)
ENTRYPOINT sh -c "$(curl -sL https://raw.githubusercontent.com/martindstone/pagerduty-cli/master/install.sh)" | wget https://runbook-actions.pagerduty.com/pd-runner.jar | echo ${RUNNER_PDTOKEN} | pd auth:set && java -jar pd-runner.jar && /bin/bash