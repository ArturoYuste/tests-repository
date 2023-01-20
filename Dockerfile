# Stage 1

FROM node:15-alpine as build-step
RUN mkdir -p /app
WORKDIR /app
COPY package.json /app
RUN npm install --force
COPY . /app
RUN npm run build

# Stage 2

FROM nginx:1.17.1-alpine
COPY --from=build-step /app/nginx.conf /etc/nginx/nginx.conf
COPY --from=build-step /app/dist/tests-project /usr/share/nginx/html
