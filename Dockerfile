# This Dockerfile is used to generate the new code files for the programming-language specific packages
# published for every schema change
FROM node:16.1.0

RUN apt-get update
RUN apt-get install unzip

ADD https://github.com/protocolbuffers/protobuf/releases/download/v3.19.0/protoc-3.19.0-linux-x86_64.zip .
RUN unzip protoc-3.19.0-linux-x86_64.zip -d /usr/local

WORKDIR /app
RUN npm install -g npm@8.1.2
RUN npm install ts-proto@1.102.0 # If you change this, also change it in package.json
RUN npm list -g

COPY . .
RUN npm install --loglevel verbose
RUN npm list

CMD bin/generate.sh && cat -n messages/*.ts && npm run build
