FROM node:12-alpine
WORKDIR /opt/srv
COPY ./srv .
RUN npm install
CMD [ "npm", "start" ]
EXPOSE 8080
