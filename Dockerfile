# Build Base Image
FROM node:alpine as builder

WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# Nginx Base Image
FROM nginx
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html

# FROM node:10.13-alpine
# ENV NODE_ENV production
# WORKDIR /app
# COPY ["package.json", "package-lock.json*", "npm-shrinkwrap.json*", "./"]
# RUN npm install --production --silent && mv node_modules ../
# COPY . .
# EXPOSE 3000
# CMD npm start