# Makefile - Commandes rapides pour le développement Vapor
# Usage: make <commande>

.PHONY: help dev stop build run clean test logs

# Commande par défaut - affiche l'aide
help:
	@echo "🚀 Commandes disponibles pour le projet Vapor:"
	@echo ""
	@echo "  make dev     - Démarre le serveur de développement avec hot reload"
	@echo "  make stop    - Arrête tous les services"
	@echo "  make build   - Construit l'image de production"
	@echo "  make run     - Lance l'application en mode production"
	@echo "  make clean   - Nettoie les images et conteneurs Docker"
	@echo "  make test    - Lance les tests (si disponibles)"
	@echo "  make logs    - Affiche les logs du serveur de développement"
	@echo ""
	@echo "🔥 Pour le développement quotidien, utilisez: make dev"

# Démarrage du serveur de développement
dev:
	@echo "🔥 Démarrage du serveur de développement..."
	docker-compose -f docker-compose.dev.yml up --build

# Arrêt des services
stop:
	@echo "🛑 Arrêt des services..."
	docker-compose -f docker-compose.dev.yml down

# Construction de l'image de production
build:
	@echo "🏗️  Construction de l'image de production..."
	docker build -f Dockerfile.simple -t vapor-task-api .

# Lancement en mode production
run: build
	@echo "🚀 Lancement en mode production..."
	docker run --rm -p 8080:8080 vapor-task-api

# Nettoyage Docker
clean:
	@echo "🧹 Nettoyage des ressources Docker..."
	docker-compose -f docker-compose.dev.yml down -v --remove-orphans
	docker system prune -f
	docker volume prune -f

# Tests (à implémenter)
test:
	@echo "🧪 Lancement des tests..."
	docker-compose -f docker-compose.dev.yml exec vapor-dev swift test

# Affichage des logs
logs:
	@echo "📋 Logs du serveur de développement..."
	docker-compose -f docker-compose.dev.yml logs -f vapor-dev