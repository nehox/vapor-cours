#!/bin/bash

# ===========================
# 🚀 Script de test avec Docker
# ===========================

echo "=================================="
echo "🎯 Test API Vapor avec Docker"
echo "=================================="
echo ""

# Vérification de Docker
if ! command -v docker &> /dev/null; then
    echo "❌ Docker n'est pas installé"
    exit 1
fi

echo "✅ Docker détecté"

# Construction de l'image
echo "🔨 Construction de l'image Swift..."
docker build -t vapor-test -f - . << 'EOF'
FROM swift:5.9-jammy

WORKDIR /app
COPY . .

# Installation des dépendances
RUN swift package resolve

# Compilation
RUN swift build

# Port
EXPOSE 8080

# Démarrage
CMD ["swift", "run", "App", "serve", "--hostname", "0.0.0.0", "--port", "8080"]
EOF

if [ $? -eq 0 ]; then
    echo "✅ Image construite avec succès"
    echo "🚀 Démarrage du conteneur..."
    echo "📡 API disponible sur http://localhost:8080"
    echo "🛑 Ctrl+C pour arrêter"
    echo ""
    
    docker run --rm -p 8080:8080 vapor-test
else
    echo "❌ Échec de la construction"
    exit 1
fi