# Quick reference

-	**Maintained by**:  
	Customer Success Engineering @ [PagerDuty](https://www.pagerduty.com/)

-	**Where to get help**:  
	- For help with the Docker images please contact the Customer Success Engineering team at <cse@pagerduty.com>.
	- For help with Automation Actions visit the [PagerDuty Knowledge Base](https://support.pagerduty.com/docs/automation-actions).
	- PagerDuty CLI please check out the [PagerDuty CLI User Guide](https://github.com/martindstone/pagerduty-cli/wiki/PagerDuty-CLI-User-Guide).

-	**Where to file issues**:  
	Issues can be filed on [GitHub](https://github.com/pagerduty-cse/pd-automation-actions-runner/issues)

-	**Source of this description**:  
	[GitHub repo's README](https://github.com/pagerduty-cse/pd-automation-actions-runner/blob/main/README.md)

# Supported tags and respective `Dockerfile` links

-   [`latest`](https://github.com/pagerduty-cse/pd-automation-actions-runner/blob/main/Dockerfile)

# What's Included

- Java 11
- PagerDuty Automation Actions Runner
- PagerDuty CLI
- Python 3
- NodeJS

# How to use this image

## Usage

### Docker

Starting a PagerDuty Automation Actions Runner container is simple:
```
$ docker run -dit --name pd-aa-runner -e RUNNER_ID=YOUR_RUNNER_ID -e RUNNER_SECRET=YOUR_RUNNER_SECRET -e RUNNER_PDTOKEN=YOUR_PAGERDUTY_API_KEY pagerdutycs/pd-automation-actions-runner:latest
```

To log into a bash shell of your container:
```
$ docker exec -it pd-aa-runner /bin/bash
```

To run PagerDuty CLI commands from the host (this example lists closed incidents):
```
$ docker exec -it pd-aa-runner pd incident:list -s=closed
```

### Kubernetes deployment
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: pd-aa-runner
  labels:
    app: pd-aa-runner
spec:
  replicas: 1
  selector:
    matchLabels:
      app: pd-aa-runner
  template:
    metadata:
      labels:
        app: pd-aa-runner
    spec:
      containers:
      - image: pagerdutycs/pd-automation-actions-runner:latest
        imagePullPolicy: Always
        name: pd-aa-runner
        env:
        - name: RUNNER_ID
          value: ${YOUR_RUNNER_ID}
        - name: RUNNER_SECRET
          value: ${YOUR_RUNNER_SECRET}
        - name: RUNNER_PDTOKEN
          value: ${YOUR_PAGERDUTY_API_KEY}
```

### Rundeck pairing

Optionally, you could pair Automation Actions to Runbook Automation Self Hosted or Rundeck OSS.
Add below environment variables:
```
Var name: RUNNER_CLOUD_RDKCLIENT_URL; value: ${RUNDECK_URL}
Var name: RUNNER_CLOUD_RDKCLIENT_TOKEN; value: ${RUNDECK_API_TOKEN}
```
