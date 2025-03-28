pipeline {
    agent any
    environment {
        PYTHON = 'python3'  // Utilisez 'python' sous Windows
    }
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/NamAngeM/python-jenkins.git'
            }
        }

        stage('Install dependencies') {
            steps {
                sh """
                ${PYTHON} -m pip install --upgrade pip
                pip install coverage pytest
                """
            }
        }

        stage('Run Tests') {
            steps {
                sh '''#!/bin/bash
                # Solution simplifiée avec pytest
                ${PYTHON} -m pytest tests/test_calculator.py --junitxml=test-results.xml -v || true
                
                # Alternative si vous préférez unittest
                # ${PYTHON} -m unittest discover -s tests -p "test_*.py" -v > test-output.log 2>&1
                # ${PYTHON} -c "from xml.etree import ElementTree as ET; \
                #   root = ET.Element('testsuite'); \
                #   with open('test-output.log') as f: \
                #       for line in f: \
                #           if line.startswith('test'): \
                #               test = ET.SubElement(root, 'testcase', {'name': line.split()[0]}); \
                #           elif 'FAIL' in line: \
                #               ET.SubElement(test, 'failure', {'message': line.strip()}); \
                #   ET.ElementTree(root).write('test-results.xml')"
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
}
