FROM node:latest
WORKDIR /app
COPY ./app .
RUN npm install
CMD npm start
HEALTHCHECK CMD curl -f localhost:3003
