FROM node:alpine

WORKDIR /usr/app

COPY ./packege.json ./
RUN npm install
COPY ./ ./

CMD ["npm", "start"]