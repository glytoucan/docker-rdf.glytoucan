FROM maven:3.3.1-jdk-7
MAINTAINER Nobuyuki Aoki "aokinobu@gmail.com"

WORKDIR /workspace

ADD run.sh /run.sh
RUN chmod a+x /run.sh

CMD ["/run.sh"]
