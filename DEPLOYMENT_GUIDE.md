# 🚀 Guide de déploiement BusinessWeb sur Dokploy

## Configuration complète pour `businessweb.guillaume-lcte.fr`

### 📋 Checklist pré-déploiement

✅ **DNS configuré** : Sous-domaine `businessweb.guillaume-lcte.fr` pointe vers votre VPS  
✅ **Dokploy installé** : Interface accessible via votre domaine admin  
✅ **Code versionné** : Projet disponible sur Git (GitHub/GitLab)  
✅ **Docker fonctionnel** : Testé en local avec `docker-compose up`  

---

## 🎯 Étapes détaillées dans l'interface Dokploy

### 1. **Accès à l'interface Dokploy**
```
URL : https://dokploy.guillaume-lcte.fr (ou votre URL admin)
```

### 2. **Création du projet**

1. **Page d'accueil Dokploy :**
   - Cliquez sur **"Create Project"** ou **"+"**
   - Nom du projet : `BusinessWeb`

2. **Création de l'application :**
   - Dans le projet créé, cliquez **"Add Application"**
   - Choisissez **"Docker Compose"**

### 3. **Configuration de l'application**

#### Onglet **"General"**
```
Application Name: businessweb
Description: Site vitrine BusinessWeb - Test technique
```

#### Onglet **"Source"**
```
Repository Type: Git
Repository URL: https://github.com/VOTRE-USERNAME/businessweb.git
Branch: main
Auto Deploy: ✅ (optionnel, pour déploiement automatique)
```

#### Onglet **"Build"**
```
Build Context: ./
Dockerfile: Dockerfile
Build Command: (laisser vide, Docker Compose gère tout)
```

### 4. **Configuration des domaines**

#### Onglet **"Domains"**
```
Domain: businessweb.guillaume-lcte.fr
Port: 8080
Path: / (racine)
Enable SSL: ✅
Certificate Provider: Let's Encrypt
Force HTTPS: ✅
```

### 5. **Variables d'environnement** (Optionnel)

#### Onglet **"Environment"**
```
NGINX_HOST=businessweb.guillaume-lcte.fr
NGINX_PORT=8080
NODE_ENV=production
```

### 6. **Configuration avancée**

#### Onglet **"Advanced"**
```
Memory Limit: 512MB (suffisant pour Nginx)
CPU Limit: 0.5 (suffisant pour ce site statique)
Restart Policy: unless-stopped
```

### 7. **Déploiement**

1. **Lancer le déploiement :**
   - Cliquez sur **"Deploy"** 
   - Suivez les logs en temps réel dans l'onglet **"Logs"**

2. **Vérification des logs :**
   ```
   ✅ Building image...
   ✅ Starting container...
   ✅ Container is running
   ✅ SSL certificate generated
   ✅ Domain configured
   ```

3. **Statut final :**
   - Status : **🟢 Running**
   - URL : `https://businessweb.guillaume-lcte.fr`

---

## 🔧 Commandes de vérification

### Vérifier le DNS
```bash
# Vérifier la résolution DNS
nslookup businessweb.guillaume-lcte.fr

# Tester la connectivité
curl -I https://businessweb.guillaume-lcte.fr
```

### Vérifier le conteneur (si accès SSH au VPS)
```bash
# Lister les conteneurs actifs
docker ps | grep businessweb

# Voir les logs du conteneur
docker logs businessweb-site

# Tester le health check
curl http://localhost:8080/health
```

---

## 🛠️ Dépannage courant

### ❌ **Erreur : Domain not accessible**
**Solution :**
1. Vérifiez que le DNS pointe vers votre VPS
2. Attendez la propagation DNS (jusqu'à 24h)
3. Vérifiez les ports 80/443 ouverts sur le firewall

### ❌ **Erreur : SSL Certificate failed**
**Solution :**
1. Vérifiez que le domaine est accessible en HTTP d'abord
2. Attendez quelques minutes et redéployez
3. Vérifiez les logs Let's Encrypt dans Dokploy

### ❌ **Erreur : Build failed**
**Solution :**
1. Vérifiez que tous les fichiers sont commitées sur Git
2. Testez le build en local : `docker build -t test .`
3. Vérifiez les logs de build dans Dokploy

### ❌ **Erreur : Container not starting**
**Solution :**
1. Vérifiez les logs du conteneur
2. Testez en local : `docker-compose up`
3. Vérifiez la configuration nginx.conf

---

## 📱 Test final

### Vérifications obligatoires :
1. **✅ Site accessible** : `https://businessweb.guillaume-lcte.fr`
2. **✅ HTTPS fonctionnel** : Cadenas vert dans le navigateur
3. **✅ Responsive** : Test mobile/tablette
4. **✅ Formulaire** : Envoyer un message de test
5. **✅ Navigation** : Tous les liens d'ancrage fonctionnent
6. **✅ Performance** : Page se charge en moins de 3 secondes

### Tests de charge (optionnel) :
```bash
# Test de performance
curl -w "@curl-format.txt" -o /dev/null https://businessweb.guillaume-lcte.fr

# Test de disponibilité
for i in {1..10}; do curl -s -o /dev/null -w "%{http_code}\n" https://businessweb.guillaume-lcte.fr; done
```

---

## 🔄 Mise à jour du site

Pour mettre à jour le site après modifications :

1. **Committer les changements :**
   ```bash
   git add .
   git commit -m "Update: description des modifications"
   git push origin main
   ```

2. **Dans Dokploy :**
   - Aller dans l'application `businessweb`
   - Cliquer sur **"Redeploy"** ou **"Rebuild"**
   - Suivre les logs de déploiement

3. **Vérification :**
   - Tester le site mis à jour
   - Vider le cache navigateur si nécessaire (Ctrl+F5)

---

## 📞 Support

En cas de problème :
1. Consultez les logs dans l'interface Dokploy
2. Vérifiez la documentation Dokploy officielle
3. Testez en local avec Docker pour isoler le problème

**Contact :** guillaume@guillaume-lcte.fr 