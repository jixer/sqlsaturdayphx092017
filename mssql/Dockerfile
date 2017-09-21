FROM microsoft/mssql-server-linux:latest

COPY . /usr/src/app
WORKDIR /usr/src/app

RUN chmod +x /usr/src/app/import-data.sh && chmod +x /usr/src/app/entrypoint.sh

CMD /bin/bash ./entrypoint.sh