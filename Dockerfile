FROM dockerregistry-v2.vih.infineon.com/node:alpine3.16 as builder
WORKDIR /app
# # Copy all files from current directory to working dir in image
COPY . .



# nginx state for serving content
FROM registry.access.redhat.com/ubi9/nginx-120



COPY --from=builder /app/nginx.conf /etc/nginx/nginx.conf
WORKDIR /code
COPY --from=builder /app .
EXPOSE 8080:8080
# Containers run nginx with global directives and daemon off
ENTRYPOINT ["nginx", "-g", "daemon off;"] 