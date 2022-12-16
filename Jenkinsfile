pipeline {
    tools {
        nodejs "node14"
    }
    stages {
        stage('Build') {
            steps {
                sh "npm install"
                sh "npm run build"
            }
        }
        stage('Deploy') {
            steps {
                sh 'ls -al'
                sh "aws s3 sync ./build s3://wollu-web --delete --profile=admin"
            }
        }
    }
}