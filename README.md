# jenkins-dockerfile

A dockerfile for jenkins. Self signed cert and adding gcc for building c code. Not hardened or ready for production use in anyway.

Installed tools for building.

- gcc
- aws cli
- terraform
- javac

## Credentials for aws cli / terraform

Replace the config and credential files in this directory before doing your docker build. 

## Launch the Jenkins instance

```
docker build -t nathanfrommpls/jenkins .
docker run --detach -p 8443:8443 -p 50000:50000 nathanfrommpls/jenkins:latest
```

Retrieve the initial admin password promptly:
```
docker exec <CONTAINER ID> cat /var/jenkins_home/secrets/initialAdminPassword
```

Access Jenkins webconsole at your localhost or whatever IP you have docker bound to:
[https://127.0.0.1:8443]

Self-Signed cert will need to be accepted.
