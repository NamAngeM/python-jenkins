pipeline {
    agent any
    environment {
        PYTHON = 'python3'  // Ou 'python' selon votre système
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
                pip install coverage
                """
            }
        }

        stage('Run Tests') {
            steps {
                sh """
                # Génère le rapport XML pour Jenkins
                ${PYTHON} -m unittest discover -s tests -p "test_*.py" -v 2>&1 | tee test-output.log
                
                # Convertit la sortie en format JUnit XML
                echo '<?xml version="1.0" encoding="UTF-8"?>' > test-results.xml
                echo '<testsuite>' >> test-results.xml
                grep -E '^(test|ok|FAILED)' test-output.log | sed -E 's/^test_(.*) \(__main__\.(.*)\)/\1/' | awk '
                    /^ok/ { printf "<testcase classname=\"%s\" name=\"%s\"/>\n", $2, $3 }
                    /^FAIL/ { printf "<testcase classname=\"%s\" name=\"%s\"><failure message=\"%s\"/></testcase>\n", $3, $4, $0 }
                ' >> test-results.xml
                echo '</testsuite>' >> test-results.xml
                
                # Affiche le résultat pour debug
                cat test-results.xml
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
