pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            } 
        }
        stage('Deploy') {
            steps {
              sh 'curl -X POST https://registry.hub.docker.com/u/cutec/promet-server/trigger/93279c47-c3ef-4100-aca8-83a63245d294/'
            }
        }
    }
    post {
        failure {
            mail to: 'jenkins@chris.ullihome.de',
                 subject: "Failed Pipeline: ${currentBuild.fullDisplayName}",
                 body: """<p>FAILED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]':</p>
                 <p>Check console output at &QUOT;<a href='${env.BUILD_URL}'>${env.JOB_NAME} [${env.BUILD_NUMBER}]</a>&QUOT;</p>"""
        }       
    }
}
