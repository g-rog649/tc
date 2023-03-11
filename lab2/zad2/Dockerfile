FROM node:14-alpine
WORKDIR /opt/srv
COPY ./srv .
RUN npm install
CMD [ "npm", "start" ]
EXPOSE 8080
