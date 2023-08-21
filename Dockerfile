FROM node:20-alpine AS build-env
WORKDIR /app
COPY package*.json ./
RUN npm i
COPY . .
RUN npm run build --prod

FROM nginx:1.13.9-alpine
COPY --from=build-env /app/dist/compute_engine_gcp_frotend/ /usr/share/nginx/html
COPY /nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80