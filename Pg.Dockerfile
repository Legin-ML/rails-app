
FROM postgres:alpine

ENV POSTGRES_PASSWORD=mypassword

COPY init.sql /docker-entrypoint-initdb.d/
