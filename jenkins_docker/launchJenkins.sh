#!/bin/bash
JENKINS_ADMIN_ID=$1
JENKINS_ADMIN_PASSWORD=$2
JENKINS_PORT=$3
docker run -d --name jenkins-rpm --group-add $(stat -c '%g' /var/run/docker.sock) -v /var/run/docker.sock:/var/run/docker.sock -p $JENKINS_PORT:8080 --env JENKINS_ADMIN_ID=$JENKINS_ADMIN_ID --env JENKINS_ADMIN_PASSWORD=$JENKINS_ADMIN_PASSWORD --env JENKINS_ADMIN_URL="http://$(hostname  -I | cut -f1 -d' '):$JENKINS_PORT/" ghcr.io/ghilesdamien/jenkins_docker:latest
