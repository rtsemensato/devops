FROM jenkins/jenkins:lts

USER root
RUN apt-get update 
RUN apt-get upgrade -y
RUN apt-get install -y maven

ARG http_port=8080
ARG agent_port=50000

EXPOSE ${http_port}
EXPOSE ${agent_port}