import Fluent
import Vapor

/**
 * routes.swift - Configuration des routes de l'application
 * 
 * Ce fichier centralise toutes les routes de votre API.
 * Il fait le lien entre les URLs et les contrôleurs qui gèrent la logique métier.
 * 
 * Organisation des routes :
 * - Routes de base (santé, info)
 * - Routes API (/tasks)
 * - Routes de test et démonstration
 */

func routes(_ app: Application) throws {
    
    // MARK: - Routes de base
    
    /**
     * Route de base - Page d'accueil
     * 
     * GET / 
     * Retourne un message de bienvenue simple
     * Utile pour vérifier que le serveur fonctionne
     */
    app.get { req async -> String in
        return "🎯 Bienvenue sur l'API de gestion des tâches Vapor !"
    }

    /**
     * Route de salutation - Pour les tests
     * 
     * GET /hello
     * Retourne un message de salutation
     * Parfait pour vérifier la connectivité
     */
    app.get("hello") { req async -> String in
        return "👋 Salut depuis Vapor ! L'API fonctionne parfaitement."
    }
    
    app.get("toto2") { req async -> String in
        return "👋 Salut depuis toto ! L'API fonctionne parfaitement."
    }
    
    /**
     * Route de salutation personnalisée
     * 
     * GET /hello/:name
     * Retourne un message de salutation personnalisé
     * Exemple d'utilisation des paramètres d'URL
     */
    app.get("hello", ":name") { req async throws -> String in
        guard let name = req.parameters.get("name") else {
            throw Abort(.badRequest, reason: "Nom manquant dans l'URL")
        }
        return "👋 Salut \(name) ! Bienvenue sur notre API Vapor."
    }
    
    // MARK: - Routes de santé et monitoring
    
    /**
     * Route de vérification de santé
     * 
     * GET /health
     * Retourne l'état de santé de l'application
     * Utile pour les systèmes de monitoring
     */
    app.get("health") { req async -> HealthStatus in
        return HealthStatus(
            status: "healthy",
            timestamp: Date().timeIntervalSince1970,
            service: "vapor-task-api",
            version: "1.0.0",
            database: "sqlite"
        )
    }
    
    // MARK: - Enregistrement des contrôleurs
    
    /**
     * Enregistrement du TaskController
     * 
     * Toutes les routes liées aux tâches (/tasks) sont gérées
     * par le TaskController défini dans Controllers/TaskController.swift
     */
    try app.register(collection: TaskController())
    
    // MARK: - Routes de démonstration (optionnelles)
    
    /**
     * Groupe de routes pour les exemples et tests
     * 
     * Ces routes peuvent être utilisées pour comprendre
     * le fonctionnement de Vapor avant de passer aux tâches
     */
    let demo = app.grouped("demo")
    
    /**
     * Exemple de retour JSON simple
     * GET /demo/json
     */
    demo.get("json") { req async -> String in
        return "Exemple de réponse JSON depuis Vapor"
    }
    
    /**
     * Exemple de gestion d'erreur
     * GET /demo/error
     */
    demo.get("error") { req async throws -> String in
        // Lance une erreur 418 pour démonstration
        throw Abort(.custom(code: 418, reasonPhrase: "I'm a teapot"), 
                   reason: "Ceci est une erreur de démonstration !")
    }
    
    /**
     * Exemple de réception de données POST
     * POST /demo/echo
     */
    demo.post("echo") { req async throws -> String in
        return "Echo reçu avec succès à \(Date())"
    }
}
