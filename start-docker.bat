@echo off
echo ================================
echo 🐳 Demarrage avec Docker
echo ================================
echo.

echo [INFO] Verification de Docker...
docker --version >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Docker n'est pas installe ou n'est pas demarre
    echo [ERROR] Veuillez installer Docker Desktop depuis https://docker.com
    pause
    exit /b 1
)

echo [SUCCESS] Docker detecte !
echo.

echo [INFO] Construction et demarrage de l'environnement...
echo [INFO] Cela peut prendre quelques minutes la premiere fois...
echo.

docker-compose -f docker-dev.yml up --build

echo.
echo [INFO] Pour arreter l'application, appuyez sur Ctrl+C