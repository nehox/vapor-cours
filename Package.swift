// swift-tools-version:5.9
import PackageDescription

/**
 * Package.swift - Configuration du projet Vapor
 * 
 * Ce fichier définit les dépendances et la configuration du projet Swift Package Manager.
 * Vapor est un framework web pour Swift qui permet de créer des API REST facilement.
 */

let package = Package(
    name: "TaskAPI",
    platforms: [
       .macOS(.v12),
       .iOS(.v15),
       .watchOS(.v8),
       .tvOS(.v15)
    ],
    dependencies: [
        // 💧 Vapor : Le framework web principal
        .package(url: "https://github.com/vapor/vapor.git", from: "4.89.0"),
        // 🗄️ Fluent : ORM (Object-Relational Mapping) pour la gestion de base de données
        .package(url: "https://github.com/vapor/fluent.git", from: "4.8.0"),
        // 📦 Fluent SQLite : Driver SQLite pour Fluent
        .package(url: "https://github.com/vapor/fluent-sqlite-driver.git", from: "4.0.0"),
    ],
    targets: [
        .executableTarget(
            name: "App",
            dependencies: [
                .product(name: "Fluent", package: "fluent"),
                .product(name: "FluentSQLiteDriver", package: "fluent-sqlite-driver"),
                .product(name: "Vapor", package: "vapor")
            ]
        ),
        .testTarget(
            name: "AppTests", 
            dependencies: [
                .target(name: "App"),
                .product(name: "XCTVapor", package: "vapor"),
            ]
        )
    ]
)
