@echo off
:: stop.bat - Arrête tous les services de développement
:: Usage: stop.bat

echo.
echo 🛑 Arrêt des services de développement...
echo.

:: Arrêt des services Docker Compose
docker-compose -f docker-compose.dev.yml down

:: Nettoyage optionnel des conteneurs orphelins
docker container prune -f >nul 2>&1

echo ✅ Services arrêtés avec succès !
echo.
pause