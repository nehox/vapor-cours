import Fluent
import Vapor

/**
 * Task.swift - Modèle de données pour les tâches
 * 
 * Ce fichier définit le modèle Task qui représente une tâche dans notre application.
 * Il utilise Fluent (l'ORM de Vapor) pour interagir avec la base de données.
 */

/**
 * Modèle Task
 * 
 * La classe Task hérite de Model, ce qui lui donne toutes les fonctionnalités
 * nécessaires pour interagir avec la base de données via Fluent.
 * 
 * Content permet de sérialiser/désérialiser automatiquement vers/depuis JSON
 */
final class Task: Model, Content {
    
    // MARK: - Propriétés de base
    
    /**
     * Schema - Nom de la table dans la base de données
     * Cette propriété statique définit le nom de la table SQLite
     */
    static let schema = "tasks"
    
    /**
     * ID - Identifiant unique de la tâche
     * @ID() génère automatiquement un UUID pour chaque nouvelle tâche
     * UUID (Universally Unique Identifier) garantit l'unicité
     */
    @ID(key: .id)
    var id: UUID?
    
    // MARK: - Champs de données
    
    /**
     * Titre de la tâche
     * @Field indique que c'est un champ de la base de données
     * "title" est le nom de la colonne dans la table
     */
    @Field(key: "title")
    var title: String
    
    /**
     * Statut de completion de la tâche
     * true = tâche terminée, false = tâche en cours
     */
    @Field(key: "is_completed")
    var isCompleted: Bool
    
    /**
     * Date de création de la tâche
     * @Timestamp génère automatiquement la date lors de la création
     */
    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?
    
    /**
     * Date de dernière modification
     * @Timestamp met à jour automatiquement la date lors de chaque modification
     */
    @Timestamp(key: "updated_at", on: .update)
    var updatedAt: Date?
    
    // MARK: - Constructeurs
    
    /**
     * Constructeur vide requis par Fluent
     * Utilisé lors de la désérialisation depuis la base de données
     */
    init() { }
    
    /**
     * Constructeur pour créer une nouvelle tâche
     * 
     * @param id: Identifiant unique (optionnel, généré automatiquement si nil)
     * @param title: Titre de la tâche
     * @param isCompleted: Statut de completion (par défaut false)
     */
    init(id: UUID? = nil, title: String, isCompleted: Bool = false) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
    }
}

// MARK: - Extensions pour la validation

/**
 * Extension pour ajouter des validations aux données
 * Cela assure que les données reçues par l'API sont valides
 */
extension Task: Validatable {
    
    /**
     * Règles de validation pour le modèle Task
     * 
     * Ces règles s'appliquent lors de la création/modification d'une tâche :
     * - Le titre ne peut pas être vide
     * - Le titre doit contenir au moins 1 caractère
     * - Le titre ne peut pas dépasser 100 caractères
     */
    static func validations(_ validations: inout Validations) {
        // Le titre est requis et ne peut pas être vide
        validations.add("title", as: String.self, is: !.empty)
        
        // Le titre doit avoir une longueur entre 1 et 100 caractères
        validations.add("title", as: String.self, is: .count(1...100))
    }
}
