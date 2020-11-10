# FROM node:alpine as builder
# WORKDIR '/app'
# COPY ./package.json ./
# #no need volume in production
# RUN npm install
# COPY ./ ./
# RUN npm run build

# #terminte the above successive block and open a new one
# FROM nginx
# #(for elastic beanstalk mapping)map to the port 80 of the container 
# EXPOSE 80
# #check from nginx at docker hub image
# COPY --from=builder /app/build /usr/share/nginx/html
# #default command -> start nginx

#docker run -p 8080:80 <image_id>

FROM node:alpine
WORKDIR '/app'
COPY ./package.json ./
RUN npm install
COPY . .
RUN npm run build

FROM nginx
EXPOSE 80
COPY --from=0 /app/build /usr/share/nginx/html