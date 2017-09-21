FROM microsoft/mssql-server-linux:latest

ENV ACCEPT_EULA Y
ENV SA_PASSWORD Pass@word1

COPY . /usr/src/app
WORKDIR /usr/src/app

RUN chmod +x /usr/src/app/import-data.sh && chmod +x /usr/src/app/entrypoint.sh

CMD /bin/bash ./entrypoint.sh