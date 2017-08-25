https://docs.docker.com/engine/userguide/eng-image/dockerfile_best-practices/#general-guidelines-and-recommendations

docker rm $(docker stop $(docker ps -aq))
docker logs 2f00689b8884

# To connect the Docker client to the Docker daemon, please set
# tcp://myIP:dockerPort
export DOCKER_HOST=tcp://172.16.65.202:2375

# docker-compose run multiple 
docker-compose up
docker-compose ps
docker-compose scale server=5

# stop / start containers
docker stop joey_zookeeper_1
docker start joey_kafka_1

# rm containers
docker rm -f $(docker ps -aq)

# rm images
docker rmi $(docker images -q)

# go inside the container
docker exec -it joey_kafka_1 bash

# check container logs by image name
docker logs joey_kafka_1

# get zk IP from inspecting the imagedoc
docker inspect joey_zookeeper_1

# bash script to build, build image, run image in a container
#!/usr/bin/env bash
mvn clean package
docker build -f src/main/java/docker/dockerfiles/Dockerfile .
docker run -p 8080:8080 $(docker images | awk '{print $3}' | awk 'FNR==2')

DEBUGGING BELOW!!!!
# Regression debugging issues
# error:
# local postgres was running and occupying port 5432, then docker couldnt connect
telnet localhost 5432
ps -ef | grep postgres
service postgresql stop

# error:
# local kafka was running and occupying port 9092, after perf test with ssh tunnel to another server
ps aux | grep 9092
kill 12345

# error
# local ip must be given a hostname of kafka in hosts file
172.16.65.202	kafka

# check which ports are in use
netstat -anp | grep 8080

alias: dockerrm = docker rm $(docker stop $(docker ps -aq))

# poll every 1 sec docker containers starting up
watch -n 1 docker ps

# clean up any untagged docker images
docker rmi $(docker images | grep "<none>" | awk "{print \$3}")

# docker is down are acting strange
sudo service docker restart

#Connecting via unix-socket to the docker-daemon
#While this bash variable was defined, docker tried to use TCP port instead of socket:
DOCKER_HOST=tcp://localhost:2375
#The solution is to unset the variable, after that docker commands work without sudo.
unset DOCKER_HOST


# Copy on write:
I think you should read up on how docker uses "copy on write" to save space. In a nutshell it means that if you run multiple containers from the same image they all share the same files. Files are only copied if a change is made to a file. So running 100 containers or 1 doesn't increase space used on your file system. It's a really interesting concept.

