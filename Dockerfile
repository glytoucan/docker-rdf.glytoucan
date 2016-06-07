FROM maven:3.3.9-jdk-8
MAINTAINER Nobuyuki Aoki "aokinobu@gmail.com"

ADD cacerts /etc/ssl/certs/java/cacerts

#WORKDIR /workspace

ADD run.sh /run.sh
RUN chmod a+x /run.sh

CMD ["/run.sh"]
