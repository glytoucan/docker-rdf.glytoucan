FROM maven:3.3.1-jdk-7
MAINTAINER Nobuyuki Aoki "aokinobu@gmail.com"

WORKDIR /workspace

CMD ["/run.sh"]
