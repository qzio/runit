FROM debian:stretch

RUN apt-get update && apt-get upgrade -y && apt-get install -y build-essential make gcc

COPY build-runit.sh /

CMD ["/build-runit.sh"]
