FROM python:rc-alpine

RUN adduser -D runuser

USER runuser
WORKDIR /home/runuser

COPY requirements.txt requirements.txt
COPY scripts/install.sh scripts/run.sh ./
COPY webserver.py ./

USER root
RUN ./install.sh
USER runuser

EXPOSE 4444
ENTRYPOINT ["./run.sh"]
