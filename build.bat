@echo off
:: build.bat - Construction pour la production
:: Usage: build.bat

echo.
echo 🏗️  Construction de l'image de production...
echo.

docker build -f Dockerfile.simple -t vapor-task-api .

if errorlevel 1 (
    echo ❌ Erreur lors de la construction !
    pause
    exit /b 1
)

echo ✅ Image de production construite avec succès !
echo 🚀 Pour lancer en production : docker run -p 8080:8080 vapor-task-api
echo.
pause