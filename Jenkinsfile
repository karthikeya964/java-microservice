pipeline {
    agent any
    environment {
        DOCKER_IMAGE = "karthikeya964/java-microservice"
        DOCKER_TAG = "latest"
        K8S_NAMESPACE = "default"
    }
    stages {
        stage('Build') {
            steps {
                script {
                    sh 'mvn clean install'
                }
            }
        }

        stage('Docker Build') {
            when {
                branch 'develop'
            }
            steps {
                script {
                    sh 'docker build -t $DOCKER_IMAGE:$DOCKER_TAG .'
                }
            }
        }

        stage('Push to Docker Registry') {
            when {
                branch 'develop'
            }
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'docke-hub-cred', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        sh "echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin"
                        sh "docker push $DOCKER_IMAGE:$DOCKER_TAG"
                    }
                }
            }
        }

        stage('Deploy to Kubernetes') {
            when {
                branch 'develop'
            }
            steps {
                script {
                    sh 'kubectl apply -f kubernetes/deployment.yaml'
                    sh 'kubectl apply -f kubernetes/service.yaml'
                }
            }
        }
    }
}
