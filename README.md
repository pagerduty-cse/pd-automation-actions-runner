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

- Java
- PagerDuty Automation Actions Runner
- PagerDuty CLI
- Python 3
- NodeJS

# How to use this image

## Usage

Starting a PagerDuty Automation Actions Runnder container is simple:
```
$ docker run -dit --name my-runner -e RUNNER_ID=YOUR_RUNNER_ID -e RUNNER_SECRET=YOUR_RUNNER_SECRET -e RUNNER_PDTOKEN=YOUR_PAGERDUTY_API_KEY pagerdutycs/pd-automation-actions-runner:latest
```

To log into a bash shell of your container:
```
$ docker exec -it my-runner /bin/bash
```

To run PagerDuty CLI commands from the host (this example lists closed incidents):
```
$ docker exec -it my-runner pd incident:list -s=closed
```
