# Utilise l'image officielle Nginx basée sur Alpine Linux (légère et sécurisée)
FROM nginx:alpine

# Maintainer information
LABEL maintainer="guillaume@businessweb.fr"
LABEL description="BusinessWeb - Site vitrine one-page"

# Copie les fichiers du site dans le répertoire de Nginx
COPY index.html /usr/share/nginx/html/
COPY style.css /usr/share/nginx/html/
COPY script.js /usr/share/nginx/html/
COPY Logo.png /usr/share/nginx/html/

# Copie la configuration Nginx personnalisée
COPY nginx.conf /etc/nginx/nginx.conf

# Change les permissions des fichiers pour l'utilisateur nginx existant
RUN chown -R nginx:nginx /usr/share/nginx/html && \
    chmod -R 755 /usr/share/nginx/html

# Créer les répertoires nécessaires avec les bonnes permissions
RUN mkdir -p /var/cache/nginx/client_temp && \
    mkdir -p /var/cache/nginx/proxy_temp && \
    mkdir -p /var/cache/nginx/fastcgi_temp && \
    mkdir -p /var/cache/nginx/uwsgi_temp && \
    mkdir -p /var/cache/nginx/scgi_temp && \
    chown -R nginx:nginx /var/cache/nginx && \
    chown -R nginx:nginx /var/log/nginx && \
    touch /var/run/nginx.pid && \
    chown nginx:nginx /var/run/nginx.pid

# Expose le port 8080 (non-privilégié)
EXPOSE 8080

# Utilise l'utilisateur non-root
USER nginx

# Commande pour démarrer Nginx
CMD ["nginx", "-g", "daemon off;"] 