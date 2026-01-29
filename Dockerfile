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

#python
RUN apt update && apt upgrade -y &&\
    apt install python3 python3-pip -y &&\
    pip install pywinrm --break-system-packages &&\
    pip install kubernetes --break-system-packages &&\
    pip install pyyaml --break-system-packages
RUN ln -s /usr/bin/python3 /usr/bin/python

#kubernetes
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && chmod +x kubectl && mv kubectl /usr/local/bin/

# install java
RUN apt-get install -y openjdk-11-jre-headless

# create automation_runner directory
RUN mkdir -p /opt/automation_runner
WORKDIR /opt/automation_runner

# install pagerduty-cli
RUN sh -c "$(curl -sL https://raw.githubusercontent.com/martindstone/pagerduty-cli/master/install.sh)"

# entrypoint (install automation_runner, set pdtoken, run automation_runner)
ENTRYPOINT wget https://runbook-actions.pagerduty.com/pd-runner.jar | echo ${RUNNER_PDTOKEN} | pd auth:set && java -jar pd-runner.jar && /bin/bash