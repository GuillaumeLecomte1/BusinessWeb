const express = require('express');
const nodemailer = require('nodemailer');
const path = require('path');

const app = express();
const PORT = process.env.PORT || 4000;

// Middleware minimal
app.use(express.json());
app.use(express.static(__dirname));

// Configuration Mailpit (adaptatif local/production)
const isProduction = process.env.NODE_ENV === 'production' || process.env.DOCKER_ENV === 'true';
const mailpitHost = isProduction ? 'mailpit' : 'mailpit.guillaume-lcte.fr';

const transporter = nodemailer.createTransport({
    host: mailpitHost,
    port: 1025,
    secure: false,
    auth: false,
    tls: {
        rejectUnauthorized: false
    }
});

console.log(`📧 Mode: ${isProduction ? 'PRODUCTION' : 'LOCAL'}`);
console.log(`📧 Mailpit host: ${mailpitHost}`);

// Test de connexion au démarrage
transporter.verify(function(error, success) {
    if (error) {
        console.log('❌ Erreur connexion Mailpit:', error);
    } else {
        console.log('✅ Connexion Mailpit OK');
    }
});

// Route principale
app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, 'index.html'));
});

// Route contact simplifiée
app.post('/api/contact', async (req, res) => {
    const { nom, email, message } = req.body;

    console.log('📧 Tentative d\'envoi:', { nom, email, message });

    try {
        // Email simple pour test
        const mailOptions = {
            from: 'test@businessweb.fr',
            to: 'contact@businessweb.fr',
            subject: `Test contact de ${nom}`,
            html: `
                <h2>Nouveau message de contact</h2>
                <p><strong>Nom:</strong> ${nom}</p>
                <p><strong>Email:</strong> ${email}</p>
                <p><strong>Message:</strong> ${message}</p>
                <p><em>Envoyé le ${new Date().toLocaleString('fr-FR')}</em></p>
            `
        };

        const result = await transporter.sendMail(mailOptions);
        console.log('✅ Email envoyé:', result.messageId);

        res.json({
            success: true,
            message: 'Email envoyé vers Mailpit !',
            messageId: result.messageId
        });

    } catch (error) {
        console.error('❌ Erreur envoi:', error);
        res.status(500).json({
            success: false,
            message: 'Erreur: ' + error.message
        });
    }
});

app.listen(PORT, () => {
    console.log(`🚀 Serveur démarré sur le port ${PORT}`);
    console.log('📧 Configuration Mailpit: mailpit:1025 (réseau Docker)');
    console.log('🌐 Site accessible via Traefik sur businessweb.guillaume-lcte.fr');
});

module.exports = app; 