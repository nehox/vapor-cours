@echo off
REM ===========================
REM 🚀 Script de test avec Docker (Windows)
REM ===========================

echo ==================================
echo 🎯 Test API Vapor avec Docker
echo ==================================
echo.

REM Vérification de Docker
docker --version >nul 2>&1
if errorlevel 1 (
    echo ❌ Docker n'est pas installé ou n'est pas démarré
    echo 💡 Veuillez démarrer Docker Desktop
    pause
    exit /b 1
)

echo ✅ Docker détecté

REM Construction de l'image
echo 🔨 Construction de l'image Swift...

REM Créer un Dockerfile temporaire
echo FROM swift:5.9-jammy > Dockerfile.tmp
echo. >> Dockerfile.tmp
echo WORKDIR /app >> Dockerfile.tmp
echo COPY . . >> Dockerfile.tmp
echo. >> Dockerfile.tmp
echo RUN swift package resolve >> Dockerfile.tmp
echo RUN swift build >> Dockerfile.tmp
echo. >> Dockerfile.tmp
echo EXPOSE 8080 >> Dockerfile.tmp
echo. >> Dockerfile.tmp
echo CMD ["swift", "run", "App", "serve", "--hostname", "0.0.0.0", "--port", "8080"] >> Dockerfile.tmp

docker build -t vapor-test -f Dockerfile.tmp .
if errorlevel 1 (
    echo ❌ Échec de la construction
    del Dockerfile.tmp
    pause
    exit /b 1
)

del Dockerfile.tmp

echo ✅ Image construite avec succès
echo 🚀 Démarrage du conteneur...
echo 📡 API disponible sur http://localhost:8080
echo 🛑 Ctrl+C pour arrêter
echo.

docker run --rm -p 8080:8080 vapor-test