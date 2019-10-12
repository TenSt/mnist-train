FROM ubuntu:latest

RUN apt update
RUN apt install git

ADD entrypoint.sh /opt/entrypoint.sh
RUN chmod 777 /opt/entrypoint.sh

ENTRYPOINT ["/opt/entrypoint.sh"]
CMD ["/opt/entrypoint.sh"]