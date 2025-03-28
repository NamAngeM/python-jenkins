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
                    branches: [[name: "${BRANCH}"]],  // Utilise la variable BRANCH
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
                sh """  // Utilisez 'bat' au lieu de 'sh' pour Windows
                ${PYTHON} -m pip install --upgrade pip
                pip install pytest pytest-html
                """
            }
        }

        stage('Test') {
            steps {
                sh """
                ${PYTHON} -m pytest src/tests/test_calculator.py --junitxml=test-results.xml -v
                """
            }
            post {
                always {
                    junit 'test-results.xml'
                }
            }
        }
    }
}
