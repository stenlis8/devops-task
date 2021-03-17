FROM ubuntu:20.04

RUN apt-get update && \ 
    apt-get install git jq iproute2 -y

RUN git clone https://"$GITHUB_USER":"$GITHUB_PASS"@github.com/stenlis8/devops-task.git

RUN /bin/bash -x /devops-task/mycommands.sh 
