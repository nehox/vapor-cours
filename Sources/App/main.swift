import Vapor
import Dispatch
import Logging

/**
 * main.swift - Point d'entrée de l'application
 * 
 * Ce fichier est le point de départ de votre application Vapor.
 * Il configure l'application et démarre le serveur HTTP.
 */

// Détection de l'environnement et configuration du logging
var env = try Environment.detect()
try LoggingSystem.bootstrap(from: &env)

// Création de l'application
let app = Application(env)

// Assure-toi que l'application se ferme proprement à la fin
defer { app.shutdown() }

do {
    // Configure l'application (base de données, routes, middlewares, etc.)
    try await configure(app)
    
    // Configuration du serveur pour Docker
    // Écoute sur toutes les interfaces réseau (0.0.0.0) pour être accessible depuis l'hôte
    app.http.server.configuration.hostname = "0.0.0.0"
    app.http.server.configuration.port = 8080
    
    // Démarre le serveur HTTP
    try await app.execute()
} catch {
    app.logger.report(error: error)
}
