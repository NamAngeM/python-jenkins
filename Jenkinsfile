pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/NamAngeM/python-jenkins.git'
            }
        }
        stage('Setup') {
            steps {
                bat 'python --version' // Vérifier que Python est installé
            }
        }
        stage('Test') {
            steps {
                bat 'python -m unittest discover tests/' // Exécuter les tests unitaires
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("mon-image:${env.BUILD_ID}")
                }
            }
        }
        stage('Deploy') {
            steps {
                bat 'echo Déploiement terminé'
            }
        }
    }
    post {
        failure {
            echo 'Build échoué - Voir les rapports de test'
        }
    }
}
