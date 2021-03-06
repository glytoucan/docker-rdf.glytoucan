build:
	sudo docker build -t aoki/rdf.glytoucan .

buildnc:
	sudo docker build --no-cache -t aoki/rdf.glytoucan .

run:
	sudo docker run -d --restart="always" -h local.rdf.glytoucan -p 81:80  -v /opt/rdf.glytoucan/tmp:/tmp -v /opt/rdf.glytoucan/maven:/root/.m2 -v $(HOME)/workspace/rdf.glytoucan:/workspace -v /opt/rdf.glytoucan/upload:/upload -v /etc/localtime:/etc/localtime -w /workspace --name="rdf.glytoucan" -e "google.oauth2.clientId=$(GOOGLE_OAUTH2_CLIENTID)" -e "google.oauth2.clientSecret=$(GOOGLE_OAUTH2_CLIENTSECRET)" -e "spring.mail.username=$(SPRING_MAIL_USERNAME)" -e "spring.mail.password=$(SPRING_MAIL_PASSWORD)" -e "SPRING_TRIPLESTORE_PASSWORD=$(SPRING_TRIPLESTORE_PASSWORD)" -e "SPRING_TRIPLESTORE_URL=$(SPRING_TRIPLESTORE_URL)" --link stanza_bluetree:stanza.glytoucan.org aoki/rdf.glytoucan

runprod:
	sudo docker run -d --restart="always" -h local.rdf.glytoucan -p 81:80  -v /opt/prod.glytoucan/tmp:/tmp -v /opt/prod.glytoucan/maven:/root/.m2 -v /mnt/jenkins/workspace/prod.glytoucan:/workspace -v /opt/prod.glytoucan/upload:/upload -v /etc/localtime:/etc/localtime -w /workspace --name="prod.glytoucan" -e "google.oauth2.clientId=$(GOOGLE_OAUTH2_CLIENTID)" -e "google.oauth2.clientSecret=$(GOOGLE_OAUTH2_CLIENTSECRET)" -e "spring.mail.username=$(SPRING_MAIL_USERNAME)" -e "spring.mail.password=$(SPRING_MAIL_PASSWORD)" -e "SPRING_TRIPLESTORE_PASSWORD=$(SPRING_TRIPLESTORE_PASSWORD)" -e "spring.triplestore.password=$(SPRING_TRIPLESTORE_PASSWORD)" -e "SPRING_TRIPLESTORE_URL=$(SPRING_TRIPLESTORE_URL)" -e "spring.triplestore.url=$(SPRING_TRIPLESTORE_URL)" --link prod.stanza_bluetree:stanza.glytoucan.org aoki/rdf.glytoucan

rundev:
	sudo docker run -d --restart="always" -h local.rdf.glytoucan -p 81:80  -v /opt/rdf.glytoucan/tmp:/tmp -v /opt/rdf.glytoucan/maven:/root/.m2 -v /home/aoki/workspace/rdf.glytoucan:/workspace -v /opt/rdf.glytoucan/upload:/upload -v /etc/localtime:/etc/localtime -w /workspace --name="beta.glytoucan" -e "google.oauth2.clientId=$(GOOGLE_OAUTH2_CLIENTID)" -e "google.oauth2.clientSecret=$(GOOGLE_OAUTH2_CLIENTSECRET)" -e "spring.mail.username=$(SPRING_MAIL_USERNAME)" -e "spring.mail.password=$(SPRING_MAIL_PASSWORD)"  -e "SPRING_TRIPLESTORE_PASSWORD=$(SPRING_TRIPLESTORE_PASSWORD)" -e "SPRING_TRIPLESTORE_URL=$(SPRING_TRIPLESTORE_URL)" --link stanza_bluetree:stanza.glytoucan.org aoki/rdf.glytoucan

runbeta:
	sudo docker run -d --restart="always" -h local.rdf.glytoucan -p 83:80  -v /opt/beta.glytoucan/tmp:/tmp -v /opt/beta.glytoucan/maven:/root/.m2 -v /mnt/jenkins/workspace/beta.glytoucan.org:/workspace -v /opt/rdf.glytoucan/upload:/upload -v /etc/localtime:/etc/localtime -w /workspace --name="beta.glytoucan" -e "google.oauth2.clientId=$(GOOGLE_OAUTH2_CLIENTID)" -e "google.oauth2.clientSecret=$(GOOGLE_OAUTH2_CLIENTSECRET)" -e "spring.mail.username=$(SPRING_MAIL_USERNAME)" -e "spring.mail.password=$(SPRING_MAIL_PASSWORD)" -e "SPRING_TRIPLESTORE_PASSWORD=$(SPRING_TRIPLESTORE_PASSWORD)" -e "spring.triplestore.password=$(SPRING_TRIPLESTORE_PASSWORD)" -e "SPRING_TRIPLESTORE_URL=$(SPRING_TRIPLESTORE_URL)" --link beta.stanza_bluetree:stanza.glytoucan.org aoki/rdf.glytoucan
#	sudo docker run -d --restart="always" -h local.beta.glytoucan -p 83:80  -v /opt/beta.glytoucan/maven:/root/.m2 -v /mnt/jenkins/workspace/beta.glytoucan.org:/workspace -w /workspace --name="beta.glytoucan" maven:3.3.3-jdk-8 mvn -U spring-boot:run

runbetatest:
	sudo docker run -d --restart="always" -h local.rdf.glytoucan -p 82:80  -v /opt/rdf.glytoucan/tmp:/tmp -v /opt/rdf.glytoucan/maven:/root/.m2 -v /mnt/jenkins/workspace/beta.glytoucan.org:/workspace -w /workspace --name="beta.glytoucan" aoki/rdf.glytoucan
	#sudo docker run -d --restart="always" -h local.rdf.glytoucan -p 82:80  -v /opt/rdf.glytoucan/maven:/root/.m2 -v /mnt/jenkins/workspace/beta.glytoucan.org:/workspace -w /workspace --name="beta.glytoucan.org" maven:3.3.3-jdk-8 mvn -U spring-boot:run

bash:
	sudo docker exec -it beta.glytoucan /bin/bash
#	sudo docker run --rm -it -h local.rdf.glytoucan -v ~/workspace/rdf.glytoucan:/workspace -v /opt/rdf.glytoucan/maven:/root/.m2 aoki/rdf.glytoucan /bin/bash

ps:
	sudo docker ps

cleanbeta:
	sudo docker stop beta.glytoucan
	sudo docker rm beta.glytoucan

cleanprod:
	sudo docker stop prod.glytoucan
	sudo docker rm prod.glytoucan

stop:
	sudo docker stop rdf.glytoucan

rm:
	sudo docker rm rdf.glytoucan

logs:
	sudo docker logs --tail=100 -f rdf.glytoucan

betalogs:
	sudo docker logs --tail=100 -f beta.glytoucan

prodlogs:
	sudo docker logs --tail=10000 -f prod.glytoucan

ip:
	sudo docker inspect -f "{{ .NetworkSettings.IPAddress }}" rdf.glytoucan

restart:
	sudo docker restart rdf.glytoucan

inspect:
	sudo docker inspect aoki/rdf.glytoucan

rerun: stop rm rund

cleandev: build stop rm rundev

clean: 
	sudo docker run -v /opt/beta.glytoucan/maven:/root/.m2 -v /home/aoki/workspace/rdf.glytoucan:/workspace -w /workspace maven:3.3.3-jdk-8 mvn clean

# not tested
dump:
	sudo docker export rdf.glytoucan > rdf.glytoucan.glycoinfo.tar

# not tested
load:
	cat rdf.glytoucan.glycoinfo.tar | docker import - aoki/docker-rdf.glytoucan:rdf.glytoucan
	
.PHONY: build run test clean
