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