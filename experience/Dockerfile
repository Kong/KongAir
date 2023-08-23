FROM node:20

ENV TINI_VERSION v0.19.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini

WORKDIR /usr/src/app
COPY package*.json ./

RUN npm ci --omit=dev

COPY . .

EXPOSE 4000
ENTRYPOINT ["/tini", "--"]
CMD [ "node", "index.js" ]