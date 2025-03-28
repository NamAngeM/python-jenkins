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
                script {
                    checkout([$class: 'GitSCM', 
                        branches: [[name: "*/${BRANCH}"]],
                        userRemoteConfigs: [[url: REPO_URL]]
                    ])
                }
            }
        }

        stage('Setup') {
            steps {
                bat """
                ${PYTHON} -m pip install --upgrade pip
                ${PYTHON} -m pip install pytest pytest-html sniffio
                """
            }
        }

        stage('Test') {
            steps {
                bat """
                ${PYTHON} -m pytest src/tests/test_calculator.py --junitxml=test-results.xml -v || exit 0
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
