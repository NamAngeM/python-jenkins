pipeline {
    agent any
    environment {
        PYTHON = 'python'  // 'python3' sur Linux/Mac
        TEST_PATH = 'src/tests/test_calculator.py'  // Chemin exact vers vos tests
    }
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/NamAngeM/python-jenkins.git'
            }
        }

        stage('Setup') {
            steps {
                sh """
                ${PYTHON} -m pip install --upgrade pip
                pip install pytest pytest-sugar
                """
            }
        }

        stage('Test') {
            steps {
                sh """
                ${PYTHON} -m pytest ${TEST_PATH} \
                    --junitxml=test-results.xml \
                    -v || echo "Certains tests ont échoué"
                """
            }
            post {
                always {
                    junit 'test-results.xml'
                    archiveArtifacts artifacts: 'test-results.xml', allowEmptyArchive: true
                }
            }
        }
    }
    post {
        success {
            echo 'Build réussi - Tous les tests passent !'
        }
        failure {
            echo 'Build échoué - Voir les rapports de test'
        }
    }
}
