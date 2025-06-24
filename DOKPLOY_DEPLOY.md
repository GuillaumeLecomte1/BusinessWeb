# 🚀 Déploiement BusinessWeb sur Dokploy

Guide pour déployer BusinessWeb sur Dokploy avec Traefik et Mailpit.

## 📋 Prérequis

✅ **Dokploy installé et fonctionnel**  
✅ **Traefik configuré**  
✅ **Mailpit déployé** (conteneur `mailpit` sur réseau `client-mailpit-qf3zat`)  
✅ **Domaine configuré** : `businessweb.guillaume-lcte.fr`

## 🎯 Configuration Dokploy

### 1. **Créer l'application dans Dokploy**

1. **Se connecter à Dokploy** : https://dokploy.guillaume-lcte.fr
2. **Créer un nouveau projet** : "BusinessWeb"
3. **Ajouter une application** : Type "Docker Compose"

### 2. **Configuration de l'application**

#### **General**
- **Name:** `businessweb`
- **Description:** Site vitrine avec formulaire de contact

#### **Source**
- **Repository Type:** Git
- **Repository URL:** `https://github.com/VOTRE-USERNAME/BusinessWeb.git`
- **Branch:** `main`
- **Auto Deploy:** ✅ (optionnel)

#### **Domains**
- **Domain:** `businessweb.guillaume-lcte.fr`
- **Path:** `/`
- **Port:** `3000`
- **Enable HTTPS:** ✅
- **Certificate Provider:** Let's Encrypt

### 3. **Networks (Important !)**

Dans la configuration avancée, s'assurer que l'application est connectée à :
- ✅ `dokploy-network` (pour Traefik)
- ✅ `client-mailpit-qf3zat` (pour accéder à Mailpit)

## 🐳 Configuration Docker

Le `docker-compose.yml` est configuré pour :

```yaml
services:
  businessweb:
    build:
      context: .
      dockerfile: Dockerfile
    restart: unless-stopped
    networks:
      - dokploy-network          # Traefik
      - client-mailpit-qf3zat     # Mailpit
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.businessweb.rule=Host(`businessweb.guillaume-lcte.fr`)"
      - "traefik.http.routers.businessweb.entrypoints=websecure"
      - "traefik.http.routers.businessweb.tls.certresolver=lets-encrypt"
      - "traefik.http.services.businessweb.loadbalancer.server.port=3000"
```

## 📧 Configuration Mailpit

L'application se connecte à Mailpit via :
- **Host:** `mailpit` (nom du conteneur)
- **Port:** `1025` (SMTP interne)
- **Interface web:** https://mailpit.guillaume-lcte.fr

## 🚀 Déploiement

### **Via Dokploy UI :**
1. **Push le code** sur votre repo Git
2. **Cliquer "Deploy"** dans Dokploy
3. **Suivre les logs** de build et déploiement

### **Via CLI (optionnel) :**
```bash
# Sur le VPS
ssh ubuntu@guillaume-lcte.fr
cd /path/to/dokploy/projects/businessweb
docker-compose up -d --build
```

## ✅ Vérification

### **1. Statut du conteneur**
```bash
docker ps | grep businessweb
```

### **2. Logs de l'application**
```bash
docker logs -f <container-id>
```

### **3. Test du site**
- **URL:** https://businessweb.guillaume-lcte.fr
- **Test formulaire:** Remplir et envoyer
- **Vérifier emails:** https://mailpit.guillaume-lcte.fr

### **4. Test API**
```bash
curl -X POST https://businessweb.guillaume-lcte.fr/api/contact \
  -H "Content-Type: application/json" \
  -d '{"nom":"Test","email":"test@example.com","message":"Test déploiement"}'
```

## 🔧 Dépannage

### **Erreur de réseau**
Si Mailpit n'est pas accessible :
```bash
# Vérifier les réseaux
docker network ls
docker network inspect client-mailpit-qf3zat
docker network inspect dokploy-network
```

### **Certificat SSL**
Si HTTPS ne fonctionne pas :
- Vérifier le domaine DNS
- Attendre la génération du certificat (quelques minutes)
- Vérifier les logs Traefik

### **Application ne démarre pas**
```bash
# Vérifier les logs
docker logs businessweb-container-name

# Rebuild si nécessaire
docker-compose up -d --build
```

## 🎯 Architecture finale

```
Internet → Traefik → BusinessWeb App → Mailpit
            ↓           ↓                ↓
        Port 443    Port 3000      Port 1025
        (HTTPS)     (Interne)      (Interne)
```

**✨ Le site sera accessible sur https://businessweb.guillaume-lcte.fr avec HTTPS automatique !** 