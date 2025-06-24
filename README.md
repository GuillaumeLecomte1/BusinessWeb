# BusinessWeb - Site vitrine avec formulaire de contact

Site vitrine one-page pour BusinessWeb avec formulaire de contact fonctionnel utilisant Mailpit.

## 🚀 Déploiement

### **Production (Dokploy + Traefik)**
Consultez [DOKPLOY_DEPLOY.md](./DOKPLOY_DEPLOY.md) pour le déploiement complet.

**URL de production :** https://businessweb.guillaume-lcte.fr

### **Test local**
```bash
# Installer les dépendances
npm install

# Démarrer le serveur
node server.js

# Site accessible sur http://localhost:3000
```

## 📧 Fonctionnement des emails

- **Local :** Utilise l'URL externe `mailpit.guillaume-lcte.fr:1025`
- **Production :** Utilise le conteneur interne `mailpit:1025`
- **Interface Mailpit :** https://mailpit.guillaume-lcte.fr

## ✨ Fonctionnalités

- ✅ Design moderne et responsive
- ✅ Formulaire de contact fonctionnel
- ✅ Envoi d'emails via Mailpit
- ✅ Mode adaptatif local/production
- ✅ Compatible Dokploy + Traefik
- ✅ HTTPS automatique avec Let's Encrypt
- ✅ Validation côté client et serveur
- ✅ Notifications visuelles animées

## 🔧 Architecture

```
Internet → Traefik → BusinessWeb App → Mailpit
            ↓           ↓                ↓
        Port 443    Port 3000      Port 1025
        (HTTPS)     (Interne)      (Interne)
```

---

**Créé par Guillaume LECOMTE** | Test technique pour agence web 