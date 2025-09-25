@echo off
:: dev.bat - Script de développement rapide avec hot reload
:: Usage: dev.bat

echo.
echo 🚀 ==============================================
echo 🔥 VAPOR DEV SERVER - HOT RELOAD ACTIVÉ
echo 🚀 ==============================================
echo.

echo 📋 Vérification de Docker...
docker --version >nul 2>&1
if errorlevel 1 (
    echo ❌ Docker n'est pas installé ou démarré !
    echo    Veuillez installer Docker Desktop et le démarrer.
    pause
    exit /b 1
)

echo ✅ Docker OK
echo.

echo 🛠️  Construction de l'image de développement (première fois = longue)...
echo ⏳ Cette étape peut prendre 5-10 minutes la première fois...
echo 🔄 Compilations suivantes seront plus rapides grâce au cache Docker !
echo.

docker-compose -f docker-compose.dev.yml build

if errorlevel 1 (
    echo ❌ Erreur lors de la construction !
    echo 💡 Vérifiez que Docker Desktop est bien démarré.
    pause
    exit /b 1
)

echo ✅ Image construite avec succès !
echo.

echo 🎯 Démarrage du serveur de développement...
echo 📝 IMPORTANT: Modifiez vos fichiers .swift et sauvegardez
echo 🔄 Le serveur redémarre automatiquement à chaque changement !
echo 🌐 API disponible sur: http://localhost:8080
echo 🛑 Pour arrêter: Ctrl+C puis lancez 'stop.bat'
echo.

:: Lancement avec Docker Compose
docker-compose -f docker-compose.dev.yml up

echo.
echo 🛑 Serveur arrêté.
pause