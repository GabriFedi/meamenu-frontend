### STAGE 1: Build ###
FROM node:10.24.1-alpine AS build
WORKDIR /usr/src/app
COPY package.json ./
RUN npm install
COPY . .
RUN npm run build:prod
### STAGE 2: Run ###
FROM nginx:1.17.1-alpine
COPY nginx.conf /etc/nginx/conf.d/meamenu.conf
COPY --from=build /usr/src/app/dist/meamenu-frontend /usr/share/nginx/html
