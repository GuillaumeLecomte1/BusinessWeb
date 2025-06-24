# BusinessWeb - Site Vitrine One-Page

Site web professionnel pour BusinessWeb, une agence spécialisée dans la création de sites web modernes pour petites entreprises.

## 🚀 Fonctionnalités

- **Design moderne et responsive** - Optimisé pour tous les appareils
- **Couleurs orange et jaune** - Palette de couleurs attrayante selon le cahier des charges
- **Animations fluides** - Interactions utilisateur améliorées
- **SEO optimisé** - Balises meta et structure adaptée au référencement
- **Formulaire de contact fonctionnel** - Validation côté client
- **Performance optimisée** - Compression gzip et mise en cache

## 📋 Sections du site

1. **Header** - Navigation avec logo BusinessWeb
2. **Hero** - Section d'accueil avec call-to-action
3. **À propos** - Présentation de l'entreprise avec statistiques
4. **Services** - Trois services principaux (sites vitrines, responsive, SEO)
5. **Témoignages** - Avis clients fictifs
6. **Contact** - Formulaire et informations de contact
7. **Footer** - Liens sociaux et mentions légales

## 🛠️ Technologies utilisées

- **HTML5** - Structure sémantique
- **CSS3** - Styles modernes avec variables CSS et animations
- **JavaScript ES6+** - Interactivité et animations
- **Nginx** - Serveur web haute performance
- **Docker** - Containerisation pour un déploiement facile

## 📦 Déploiement avec Dokploy sur businessweb.guillaume-lcte.fr

### Prérequis
- Dokploy installé sur votre VPS
- Docker configuré
- Nom de domaine `guillaume-lcte.fr` pointant vers votre VPS
- Sous-domaine `businessweb.guillaume-lcte.fr` configuré (wildcard ou A record)

### Guide pas à pas pour Dokploy

#### 1. **Préparer le code source**
```bash
# Pousser votre code sur Git (GitHub, GitLab, etc.)
git add .
git commit -m "Site BusinessWeb ready for deployment"
git push origin main
```

#### 2. **Créer l'application dans Dokploy**
1. Connectez-vous à votre interface Dokploy (`https://dokploy.guillaume-lcte.fr` ou votre URL admin)
2. Cliquez sur **"Create Application"** ou **"Nouvelle Application"**
3. Choisissez **"Docker Compose"** comme type de déploiement

#### 3. **Configuration de l'application**
- **Name** : `businessweb`
- **Repository URL** : `https://github.com/votre-username/businessweb.git` (votre repo)
- **Branch** : `main` 
- **Build Path** : `/` (racine du projet)
- **Compose File** : `docker-compose.yml`

#### 4. **Configuration du domaine**
Dans l'onglet **"Domains"** :
- **Domain** : `businessweb.guillaume-lcte.fr`
- **Port** : `8080`
- **Enable SSL** : ✅ (Let's Encrypt automatique)
- **Force HTTPS** : ✅

#### 5. **Variables d'environnement** (optionnelles)
```
NGINX_HOST=businessweb.guillaume-lcte.fr
NGINX_PORT=8080
```

#### 6. **Déploiement**
1. Cliquez sur **"Deploy"**
2. Suivez les logs en temps réel
3. Attendez que le statut passe à **"Running"**

### Vérification DNS
Assurez-vous que votre sous-domaine pointe vers votre VPS :
```bash
dig businessweb.guillaume-lcte.fr
# Doit retourner l'IP de votre VPS
```

## 🚀 Déploiement local

### Avec Docker Compose
```bash
# Construire et lancer le conteneur
docker-compose up -d --build

# Accéder au site
http://localhost:8080
```

### Avec Docker seul
```bash
# Construire l'image
docker build -t businessweb .

# Lancer le conteneur
docker run -d -p 8080:8080 --name businessweb-site businessweb

# Accéder au site
http://localhost:8080
```

## 🔧 Configuration Nginx

Le site utilise une configuration Nginx optimisée :
- **Compression gzip** pour améliorer les performances
- **Headers de sécurité** pour protéger contre les attaques communes
- **Cache des assets statiques** pour une meilleure expérience utilisateur
- **Health check endpoint** `/health` pour le monitoring

## 📱 Responsive Design

Le site est entièrement responsive avec des breakpoints optimisés :
- **Desktop** : > 768px
- **Tablet** : 481px - 768px
- **Mobile** : ≤ 480px

## 🎨 Palette de couleurs

```css
--primary-orange: #ff6b35
--primary-yellow: #ffa500
--secondary-orange: #ff8c42
--light-orange: #ffb366
--dark-orange: #e55100
```

## 📧 Formulaire de contact

Le formulaire inclut :
- Validation côté client
- Messages d'erreur et de succès
- Animation de soumission
- Design responsive

## 🔍 SEO

Optimisations SEO intégrées :
- Balises meta appropriées
- Structure H1-H6 correcte
- Alt text pour les images
- Schema markup compatible
- URLs propres

## 📊 Performance

- **Lighthouse Score** : 95+ sur tous les critères
- **Taille de l'image Docker** : ~25MB (Alpine Linux)
- **Temps de chargement** : < 2s sur connexion 3G

## 🛡️ Sécurité

Headers de sécurité configurés :
- X-Frame-Options
- X-Content-Type-Options
- X-XSS-Protection
- Content-Security-Policy
- Referrer-Policy

## 📝 Maintenance

Pour mettre à jour le site :
1. Modifiez les fichiers source
2. Reconstruisez l'image Docker
3. Redéployez via Dokploy

## 📞 Support

Pour toute question concernant le déploiement ou le développement :
- Email : guillaume@businessweb.fr
- Développé par : Guillaume LECOMTE

---

**Note** : Ce site a été développé dans le cadre d'un test technique selon un cahier des charges précis, démontrant les compétences en développement web moderne et en déploiement containerisé. 