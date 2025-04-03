pipeline {
    agent any

    environment {
        PYTHON = 'python3'
    }

    stages {
        stage('Install Dependencies') {
            steps {
                sh """
                ${PYTHON} -m pip install -r requirements.txt
                """
            }
        }
        
        stage('Run Tests') {
            steps {
                sh """
                ${PYTHON} -m pytest tests/test_calculator.py \
                    --junitxml=test-results.xml \
                    --cov=src \
                    --cov-report=xml:coverage.xml
                """
            }
            post {
                always {
                    junit 'test-results.xml'
                    publishCoverage adapters: [coberturaAdapter('coverage.xml')]
                }
            }
        }
    }
}
