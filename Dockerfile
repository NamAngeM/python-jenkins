# Utiliser une image Python officielle comme base
FROM python:3.9-slim

# Définir le répertoire de travail dans le conteneur
WORKDIR /app

# Copier le fichier requirements.txt et installer les dépendances
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copier le code source, en incluant le sous-répertoire 'src'
COPY src/ ./src/

# Exposer le port sur lequel l'application va écouter (si applicable)
EXPOSE 5000

# Commande pour exécuter l'application
CMD ["python", "src/calculator.py"]
