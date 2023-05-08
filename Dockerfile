ARG NODE_VERSION=18.16.0

FROM node:${NODE_VERSION}
RUN apt update
WORKDIR /usr/src/app
COPY package.json ./
COPY index.js ./
RUN npm install
RUN curl -L https://github.com/hasura/graphql-engine/raw/stable/cli/get.sh | bash

CMD [ "node", "index"]