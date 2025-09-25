#!/bin/bash

# Script de surveillance des fichiers avec hot reload optimisé
# Supprime les avertissements visionOS qui causent des boucles infinies

echo "🔥 Démarrage du serveur de développement avec hot reload optimisé..."

# Fonction pour construire et démarrer le serveur
build_and_run() {
    echo "🔄 Recompilation détectée..."
    
    # Arrêter le processus précédent s'il existe
    if [ ! -z "$SERVER_PID" ]; then
        kill $SERVER_PID 2>/dev/null || true
        wait $SERVER_PID 2>/dev/null || true
    fi
    
    # Compiler avec suppression des warnings visionOS
    echo "⚙️  Compilation en cours..."
    if swift build 2>&1 | grep -v "unrecognized platform name.*visionOS" | grep -v "define-availability argument"; then
        echo "✅ Compilation réussie"
        
        # Démarrer le serveur en arrière-plan avec filtrage des warnings
        swift run 2>&1 | grep -v "unrecognized platform name.*visionOS" | grep -v "define-availability argument" &
        SERVER_PID=$!
        
        echo "🌐 Serveur redémarré (PID: $SERVER_PID)"
        echo "🌐 Serveur disponible sur : http://localhost:8080"
    else
        echo "❌ Erreur de compilation"
    fi
}

# Première construction
build_and_run

# Surveillance des fichiers Swift
echo "👀 Surveillance des fichiers Sources/ ..."
echo "   (Ctrl+C pour arrêter)"

# Utiliser inotifywait si disponible, sinon utiliser une boucle simple
if command -v inotifywait >/dev/null 2>&1; then
    # Surveillance avec inotifywait (plus efficace)
    while inotifywait -r -e modify,create,delete Sources/ 2>/dev/null; do
        sleep 1  # Éviter les recompilations trop fréquentes
        build_and_run
    done
else
    # Boucle de surveillance simple
    LAST_MODIFIED=0
    while true; do
        CURRENT_MODIFIED=$(find Sources/ -name "*.swift" -type f -exec stat -c %Y {} \; 2>/dev/null | sort -n | tail -1)
        if [ "$CURRENT_MODIFIED" != "$LAST_MODIFIED" ] && [ "$CURRENT_MODIFIED" != "" ]; then
            LAST_MODIFIED=$CURRENT_MODIFIED
            sleep 1  # Éviter les recompilations trop fréquentes
            build_and_run
        fi
        sleep 2
    done
fi

# Nettoyage à la sortie
trap 'kill $SERVER_PID 2>/dev/null || true; exit' INT TERM