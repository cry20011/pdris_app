pipeline {
    agent any
    tools { 
        maven 'Maven3' 
    }
    stages {
        stage('build') {
            steps {
                sh 'mvn -f java/pom.xml clean verify'
            }
        }
        stage('test') {
            steps {
                sh 'mvn -f java/pom.xml test'
            }
        }
        stage('allure') {
            steps {
                allure([
                        includeProperties: false,
                        jdk: '',
                        properties: [],
                        reportBuildPolicy: 'ALWAYS',
                        results: [[path: 'java/target/results']]
                    ])

            }
        }
        stage('sonarQube') {
            steps {
                withSonarQubeEnv('SonarQube') {
                    sh "${tool 'SonarQube'}/bin/sonar-scanner \
                    -Dsonar.projectKey=pipeline \
                    -Dsonar.sources=java/src/main \
                    -Dsonar.tests=java/src/test \
                    -Dsonar.java.binaries=java/target/classes \
                    -Dsonar.junit.reportPaths=java/target/surefire-reports \
                    -Dsonar.coverage.jacoco.xmlReportPaths=java/target/site/jacoco/jacoco.xml"
                }
            }
        }
    }
}