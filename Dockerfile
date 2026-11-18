# Maintained stable nginx line on Alpine, so security fixes keep arriving.
FROM nginx:stable-alpine
COPY app/ /usr/share/nginx/html/
EXPOSE 80
HEALTHCHECK --interval=30s --timeout=3s CMD wget -qO- http://localhost/health.json || exit 1
