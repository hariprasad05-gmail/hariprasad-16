pipeline {
    agent any

    environment {
        NODE_HOME = '.\\Program Files\\nodejs'
        PATH = "${env.NODE_HOME};${env.PATH}"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Install Dependencies') {
            steps {
                dir('template-vanilla') {
                    bat 'npm install'
                }
        }
            }
       
        stage('Build') {
            steps {
                dir('template-vanilla') {
                    bat 'npm run build'
                }
            }
            }
    }
    post {
        always {
            archiveArtifacts artifacts: 'build/**', allowEmptyArchive: true
        }
        failure {
            mail to: 'your-email@example.com',
                 subject: "Build Failed: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                 body: "Check Jenkins for details."
        }
    }
}