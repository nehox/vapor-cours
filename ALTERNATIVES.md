# 🚀 Solutions alternatives pour développer l'API

Si Swift/Vapor pose des problèmes d'installation, voici des alternatives pour comprendre les concepts :

## Option 1 : Développement avec Docker 🐳

**Prérequis :** Docker Desktop installé et démarré

```bash
# Windows
test-docker.bat

# Linux/macOS
./test-docker.sh
```

## Option 2 : Version Node.js équivalente 🟢

Pour comprendre les concepts REST/CRUD, voici une version Node.js identique :

### Installation
```bash
npm init -y
npm install express sqlite3 cors
```

### Code équivalent (server.js)
```javascript
const express = require('express');
const sqlite3 = require('sqlite3').verbose();
const cors = require('cors');

const app = express();
app.use(express.json());
app.use(cors());

// Base de données SQLite
const db = new sqlite3.Database('tasks.db');

// Création de la table
db.run(`CREATE TABLE IF NOT EXISTS tasks (
    id TEXT PRIMARY KEY,
    title TEXT NOT NULL,
    isCompleted BOOLEAN DEFAULT FALSE,
    createdAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    updatedAt DATETIME DEFAULT CURRENT_TIMESTAMP
)`);

// Routes CRUD identiques à Vapor
app.get('/', (req, res) => {
    res.json({
        message: "🎯 API de gestion des tâches (Version Node.js)",
        version: "1.0.0",
        endpoints: {
            "GET /": "Page d'accueil",
            "GET /tasks": "Lister toutes les tâches",
            "POST /tasks": "Créer une nouvelle tâche",
            "GET /tasks/:id": "Récupérer une tâche",
            "PUT /tasks/:id": "Modifier une tâche",
            "DELETE /tasks/:id": "Supprimer une tâche"
        }
    });
});

app.get('/tasks', (req, res) => {
    db.all("SELECT * FROM tasks ORDER BY createdAt DESC", (err, rows) => {
        if (err) return res.status(500).json({ error: err.message });
        res.json(rows);
    });
});

app.post('/tasks', (req, res) => {
    const { title, isCompleted = false } = req.body;
    const id = require('crypto').randomUUID();
    
    if (!title || title.trim() === '') {
        return res.status(400).json({ error: "Le titre est requis" });
    }
    
    db.run(
        "INSERT INTO tasks (id, title, isCompleted) VALUES (?, ?, ?)",
        [id, title, isCompleted],
        function(err) {
            if (err) return res.status(500).json({ error: err.message });
            
            db.get("SELECT * FROM tasks WHERE id = ?", [id], (err, row) => {
                if (err) return res.status(500).json({ error: err.message });
                res.status(201).json(row);
            });
        }
    );
});

app.get('/tasks/:id', (req, res) => {
    db.get("SELECT * FROM tasks WHERE id = ?", [req.params.id], (err, row) => {
        if (err) return res.status(500).json({ error: err.message });
        if (!row) return res.status(404).json({ error: "Tâche non trouvée" });
        res.json(row);
    });
});

app.put('/tasks/:id', (req, res) => {
    const { title, isCompleted } = req.body;
    
    db.run(
        "UPDATE tasks SET title = ?, isCompleted = ?, updatedAt = CURRENT_TIMESTAMP WHERE id = ?",
        [title, isCompleted, req.params.id],
        function(err) {
            if (err) return res.status(500).json({ error: err.message });
            if (this.changes === 0) return res.status(404).json({ error: "Tâche non trouvée" });
            
            db.get("SELECT * FROM tasks WHERE id = ?", [req.params.id], (err, row) => {
                if (err) return res.status(500).json({ error: err.message });
                res.json(row);
            });
        }
    );
});

app.delete('/tasks/:id', (req, res) => {
    db.run("DELETE FROM tasks WHERE id = ?", [req.params.id], function(err) {
        if (err) return res.status(500).json({ error: err.message });
        if (this.changes === 0) return res.status(404).json({ error: "Tâche non trouvée" });
        res.status(204).send();
    });
});

const PORT = 8080;
app.listen(PORT, () => {
    console.log(`🚀 API démarrée sur http://localhost:${PORT}`);
    console.log(`📖 Documentation : http://localhost:${PORT}`);
});
```

### Démarrage
```bash
node server.js
```

## Option 3 : Développement en ligne ☁️

### Gitpod
1. Ouvrez https://gitpod.io/#https://github.com/VOTRE-REPO
2. Tout sera configuré automatiquement

### GitHub Codespaces
1. Sur votre repo GitHub, cliquez "Code" > "Codespaces"
2. Créez un nouveau Codespace

## Option 4 : Machine virtuelle Swift 🔧

Si vous voulez absolument Swift natif :

```bash
# WSL2 + Ubuntu
wsl --install
# Puis suivre les instructions Linux du README
```

## 📊 Comparaison des solutions

| Solution | Facilité | Performance | Apprentissage Swift |
|----------|----------|-------------|-------------------|
| Docker | ⭐⭐⭐⭐ | ⭐⭐⭐ | ⭐⭐⭐⭐⭐ |
| Node.js | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐ |
| Gitpod | ⭐⭐⭐⭐⭐ | ⭐⭐⭐ | ⭐⭐⭐⭐⭐ |
| WSL2 | ⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ |

**Recommandation :** Commencez par Docker si vous voulez Swift, ou Node.js pour comprendre rapidement les concepts REST.