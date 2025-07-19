FROM node:18

WORKDIR /app

COPY app/ . 
COPY package.json .

RUN npm install

CMD ["node", "index.js"]
