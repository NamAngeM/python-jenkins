pipeline {
    agent any
    environment {
        PYTHON = 'python'  // Pour Windows
        REPO_URL = 'https://github.com/NamAngeM/python-jenkins.git'
        BRANCH = 'main'  // Branche principale correcte
    }
    stages {
        stage('Checkout') {
            steps {
                checkout([
                    $class: 'GitSCM',
                    branches: [[name: "${BRANCH}"]],  // Utilisation de la variable BRANCH
                    extensions: [],
                    userRemoteConfigs: [[
                        url: "${REPO_URL}",
                        credentialsId: ''  // Laissez vide pour dépôt public
                    ]]
                ])
            }
        }

        stage('Setup') {
            steps {
                bat '''
                python -m pip install --upgrade pip
                python -m pip install pytest pytest-html
                '''
            }
        }

        stage('Test') {
            steps {
                bat '''
                python -m pytest src/tests/test_calculator.py --junitxml=test-results.xml -v
                '''
            }
            post {
                always {
                    junit 'test-results.xml'
                }
            }
        }
    }
}
