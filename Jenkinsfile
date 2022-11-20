pipeline {
    agent any
    tools { 
        maven 'Maven 3.3.9' 
        jdk 'jdk8' 
    }
    stages {
        stage('build') {
            steps {
                sh 'mvn -f pom.xml clean verify'
            }
        }
        stage('test') {
            steps {
                sh 'mvn -f pom.xml test'
            }
        }
        stage('allure') {
            steps {
                allure([
                        includeProperties: false,
                        jdk: '',
                        properties: [],
                        reportBuildPolicy: 'ALWAYS',
                        results: [[path: 'java/target/allure-results']]
                    ])
            }
        }
        stage('sonar_qube') {
            steps {
                script {
                    def scannerHome = tool 'MySonar';
                    withSonarQubeEnv('MySonar') {
                        sh "${scannerHome}/bin/sonar-scanner \
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
}