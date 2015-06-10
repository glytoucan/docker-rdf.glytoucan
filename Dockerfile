FROM maven:latest
MAINTAINER Nobuyuki Aoki "aokinobu@gmail.com"

#WORKDIR /workspace

ADD run.sh /run.sh
RUN chmod a+x /run.sh

CMD ["/run.sh"]
