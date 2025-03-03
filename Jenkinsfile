pipeline {
    agent any

    environment {
        IMAGE_NAME = "angular-app"
        CONTAINER_NAME = "angular-container"
        PORT = "4200"
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'master', url: 'https://github.com/viplavshrotria/cms2.git'
            }
        }

        stage('Build and Deploy') {
            steps {
                sh '''
                npm install
                npm run build -- --configuration=production
                docker build -t $IMAGE_NAME .
                docker stop $CONTAINER_NAME || true
                docker rm $CONTAINER_NAME || true
                docker run -d --name $CONTAINER_NAME -p $PORT:$PORT $IMAGE_NAME
                '''
            }
        }
    }
}
