FROM node:9

WORKDIR /app

COPY src/package.json /app
RUN npm install
COPY ./src /app

CMD node index.js