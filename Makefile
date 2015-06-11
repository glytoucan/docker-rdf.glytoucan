build:
	sudo docker build -t aoki/rdf.glytoucan .

buildnc:
	sudo docker build --no-cache -t aoki/rdf.glytoucan .

run:
	sudo docker run -d --restart="always" -h local.rdf.glytoucan -p 81:8080  -v /opt/rdf.glytoucan/maven:/root/.m2 -v /mnt/jenkins/workspace/rdf.glytoucan-ws:/workspace -w /workspace --name="rdf.glytoucan" maven:3.3.3-jdk-8 mvn -U spring-boot:run
#	sudo docker run -d --restart="always" -h local.rdf.glytoucan -p 81:8080 -v /opt/rdf.glytoucan/maven:/root/.m2 -v /mnt/jenkins/workspace/rdf.glytoucan-ws:/workspace --name="rdf.glytoucan" aoki/rdf.glytoucan

rundev:
	sudo docker run -d --restart="always" -h local.rdf.glytoucan -p 81:8080  -v /opt/rdf.glytoucan/maven:/root/.m2 -v ~/workspace/rdf.glytoucan:/workspace -w /workspace --name="rdf.glytoucan" maven:3.3.3-jdk-8 mvn -U --debug spring-boot:run
#	sudo docker run -d --restart="always" -h local.rdf.glytoucan -p 81:8080  -v /opt/rdf.glytoucan/maven:/root/.m2 -v ~/workspace/rdf.glytoucan:/workspace --name="rdf.glytoucan" aoki/rdf.glytoucan

bash:
	sudo docker exec -it rdf.glytoucan /bin/bash
#	sudo docker run --rm -it -h local.rdf.glytoucan -v ~/workspace/rdf.glytoucan:/workspace -v /opt/rdf.glytoucan/maven:/root/.m2 aoki/rdf.glytoucan /bin/bash

ps:
	sudo docker ps

stop:
	sudo docker stop rdf.glytoucan

rm:
	sudo docker rm rdf.glytoucan

logs:
	sudo docker logs --tail=100 -f rdf.glytoucan

ip:
	sudo docker inspect -f "{{ .NetworkSettings.IPAddress }}" rdf.glytoucan

restart:
	sudo docker restart rdf.glytoucan

inspect:
	sudo docker inspect aoki/rdf.glytoucan

rerun: stop rm rund

cleandev: build stop rm rundev

clean: build stop rm rund

# not tested
dump:
	sudo docker export rdf.glytoucan > rdf.glytoucan.glycoinfo.tar

# not tested
load:
	cat rdf.glytoucan.glycoinfo.tar | docker import - aoki/docker-rdf.glytoucan:rdf.glytoucan
	
.PHONY: build run test clean
