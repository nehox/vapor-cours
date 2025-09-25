import Vapor

/**
 * ResponseModels.swift - Modèles de réponse pour l'API
 * 
 * Ce fichier contient les structures utilisées pour
 * standardiser les réponses de l'API.
 */

// MARK: - Modèles de réponse de base

/**
 * Structure pour les informations de l'API
 */
struct APIInfo: Content {
    let api: String
    let version: String
    let endpoints: [String: String]
}

/**
 * Structure pour le statut de santé de l'application
 */
struct HealthStatus: Content {
    let status: String
    let timestamp: Double
    let service: String
    let version: String
    let database: String
}

/**
 * Structure pour les statistiques des tâches
 */
struct TaskStats: Content {
    let totalTasks: Int
    let completedTasks: Int
    let pendingTasks: Int
    let completionRate: Double
    
    private enum CodingKeys: String, CodingKey {
        case totalTasks = "total_tasks"
        case completedTasks = "completed_tasks"
        case pendingTasks = "pending_tasks"
        case completionRate = "completion_rate"
    }
}

/**
 * Structure pour la documentation de l'API
 */
struct APIDocumentation: Content {
    let name: String
    let description: String
    let author: String
    let technologies: [String]
    let features: [String]
}

// MARK: - Réponses d'erreur standardisées

/**
 * Structure de réponse d'erreur standardisée
 */
struct ErrorResponse: Content {
    let error: Bool
    let reason: String
    let timestamp: Double
    
    init(reason: String) {
        self.error = true
        self.reason = reason
        self.timestamp = Date().timeIntervalSince1970
    }
}

/**
 * Structure de réponse de succès standardisée
 */
struct SuccessResponse: Content {
    let success: Bool
    let message: String
    let timestamp: Double
    
    init(message: String) {
        self.success = true
        self.message = message
        self.timestamp = Date().timeIntervalSince1970
    }
}

// MARK: - Réponses spécifiques aux tâches

/**
 * Structure de réponse pour la création d'une tâche
 */
struct TaskCreationResponse: Content {
    let success: Bool
    let message: String
    let task: Task
    let id: UUID
    let timestamp: Double
    
    init(task: Task) {
        self.success = true
        self.message = "Tâche créée avec succès"
        self.task = task
        self.id = task.id ?? UUID()
        self.timestamp = Date().timeIntervalSince1970
    }
}

/**
 * Structure de réponse pour la mise à jour d'une tâche
 */
struct TaskUpdateResponse: Content {
    let success: Bool
    let message: String
    let task: Task
    let timestamp: Double
    
    init(task: Task) {
        self.success = true
        self.message = "Tâche mise à jour avec succès"
        self.task = task
        self.timestamp = Date().timeIntervalSince1970
    }
}

/**
 * Structure de réponse pour la suppression d'une tâche
 */
struct TaskDeletionResponse: Content {
    let success: Bool
    let message: String
    let deletedId: UUID
    let timestamp: Double
    
    init(deletedId: UUID) {
        self.success = true
        self.message = "Tâche supprimée avec succès"
        self.deletedId = deletedId
        self.timestamp = Date().timeIntervalSince1970
    }
}

/**
 * Structure de réponse pour une liste de tâches
 */
struct TaskListResponse: Content {
    let success: Bool
    let count: Int
    let tasks: [Task]
    let timestamp: Double
    
    init(tasks: [Task]) {
        self.success = true
        self.count = tasks.count
        self.tasks = tasks
        self.timestamp = Date().timeIntervalSince1970
    }
}