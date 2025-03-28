pipeline {
    agent any
    environment {
        // Configuration Docker - À PERSONNALISER
        DOCKER_IMAGE_NAME = 'python-jenkins-app'  // Nom de votre application
        DOCKER_REGISTRY = 'registry.hub.docker.com'
        // Le username est maintenant dans les credentials Jenkins
    }

    stages {
        // Étape 1 - Récupération du code
        stage('Checkout') {
            steps {
                git url: 'https://github.com/NamAngeM/python-jenkins.git',
                    branch: 'main'
            }
        }

        // Étape 2 - Installation et tests
        stage('Test') {
            steps {
                sh '''
                python -m pip install --upgrade pip
                pip install -r requirements.txt
                pytest tests/ --junitxml=test-results.xml
                '''
            }
            post {
                always {
                    junit 'test-results.xml'
                }
            }
        }

        // Étape 3 - Build Docker
        stage('Build') {
            when { 
                expression { currentBuild.resultIsBetterOrEqualTo('SUCCESS') } 
            }
            steps {
                script {
                    docker.build("${DOCKER_IMAGE_NAME}:${env.BUILD_ID}")
                }
            }
        }

        // Étape 4 - Push vers Docker Hub
        stage('Push') {
            when { 
                expression { currentBuild.resultIsBetterOrEqualTo('SUCCESS') } 
            }
            steps {
                script {
                    docker.withRegistry("https://${DOCKER_REGISTRY}", 'docker-hub-creds') {
                        // Format: angenam/python-jenkins-app:123
                        docker.image("${DOCKER_IMAGE_NAME}:${env.BUILD_ID}").push()
                        // Tag 'latest' optionnel
                        docker.image("${DOCKER_IMAGE_NAME}:${env.BUILD_ID}").push('latest')
                    }
                }
            }
        }
    }

    post {
        always {
            cleanWs()
            script {
                currentBuild.description = 
                    "Image: angenam/${DOCKER_IMAGE_NAME}:${env.BUILD_ID}"
            }
        }
    }
}
