FROM node:20-alpine

WORKDIR /

COPY package*.json ./
RUN npm install --production

# Copy application files
COPY . .

# Install required system packages for deployment script
RUN apk add --no-cache docker-cli bash

EXPOSE 3456

CMD ["node", "webhook.js"]
