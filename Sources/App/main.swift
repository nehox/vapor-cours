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
    
    // Démarre le serveur HTTP
    // Par défaut, le serveur écoute sur localhost:8080
    try await app.execute()
} catch {
    app.logger.report(error: error)
}
