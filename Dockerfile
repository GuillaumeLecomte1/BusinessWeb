FROM node:18-alpine

LABEL maintainer="guillaume@businessweb.fr"

WORKDIR /app

COPY package*.json ./
RUN npm ci --only=production

COPY . .

# Variables d'environnement pour la production
ENV NODE_ENV=production
ENV DOCKER_ENV=true

EXPOSE 4000

CMD ["node", "server.js"] 