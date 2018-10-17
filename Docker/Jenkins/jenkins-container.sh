#!/bin/bash
docker volume create jenkins_home
docker run -d -p 8080:8080 -p 50000:50000 -v jenkins_home:/var/jenkins_home --name jenkins paschualetto/jenkins
#docker container exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword