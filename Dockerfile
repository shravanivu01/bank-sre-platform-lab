FROM nginx:1.27-alpine
COPY app/ /usr/share/nginx/html/
EXPOSE 80
HEALTHCHECK --interval=30s --timeout=3s CMD wget -qO- http://localhost/health.json || exit 1
