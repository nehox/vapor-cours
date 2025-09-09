import Vapor

/**
 * main.swift - Point d'entrée de l'application
 * 
 * Ce fichier est le point de départ de votre application Vapor.
 * Il configure l'application et démarre le serveur HTTP.
 */

@main
enum Entrypoint {
    static func main() async throws {
        
        // Création d'une nouvelle application Vapor avec la configuration par défaut
        var env = try Environment.detect()
        try LoggingSystem.bootstrap(from: &env)
        let app = Application(env)
        
        // Assure-toi que l'application se ferme proprement à la fin
        defer { app.shutdown() }
        
        // Configure l'application (base de données, routes, middlewares, etc.)
        try await configure(app)
        
        // Démarre le serveur HTTP
        // Par défaut, le serveur écoute sur localhost:8080
        try await app.execute()
    }
}
