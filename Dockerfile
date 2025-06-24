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

# Crée un utilisateur non-root pour la sécurité
RUN addgroup -g 1001 -S nginx && \
    adduser -S -D -H -u 1001 -h /var/cache/nginx -s /sbin/nologin -G nginx -g nginx nginx

# Change les permissions des fichiers
RUN chown -R nginx:nginx /usr/share/nginx/html && \
    chown -R nginx:nginx /var/cache/nginx && \
    chown -R nginx:nginx /var/log/nginx && \
    chown -R nginx:nginx /etc/nginx/conf.d

# Change les permissions des répertoires temporaires
RUN touch /var/run/nginx.pid && \
    chown -R nginx:nginx /var/run/nginx.pid

# Expose le port 8080 (non-privilégié)
EXPOSE 8080

# Utilise l'utilisateur non-root
USER nginx

# Commande pour démarrer Nginx
CMD ["nginx", "-g", "daemon off;"] 