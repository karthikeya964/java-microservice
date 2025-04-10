pipeline {
    agent any
    environment {
        DOCKER_IMAGE = "karthik449/java-microservice:${env.BRANCH_NAME}"
    }
    stages {
        stage('Checkout') {
            steps {
                checkout scm  // Checkout the code from the GitHub repository
            }
        }
        stage('Build & Test') {
            steps {
                sh 'mvn clean install'  // Build and test with Maven
            }
        }
        stage('Docker Build & Push') {
            when {
                branch 'develop'  // Only build and push Docker image for the 'develop' branch
            }
            steps {
                sh 'docker build -t $DOCKER_IMAGE .'  // Build the Docker image
                withCredentials([usernamePassword(credentialsId: 'docker-hub-cred', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                    sh """
                        echo $PASSWORD | docker login -u $USERNAME --password-stdin  // Login to DockerHub
                        docker push $DOCKER_IMAGE  // Push Docker image to registry
                    """
                }
            }
        }
        stage('Deploy to Kubernetes') {
            when {
                branch 'develop'  // Only deploy to Kubernetes for the 'develop' branch
            }
            steps {
                sh '''
                    kubectl apply -f k8s/deployment.yaml  // Apply Kubernetes deployment
                    kubectl apply -f k8s/service.yaml  // Apply Kubernetes service
                '''
            }
        }
    }
}
