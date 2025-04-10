pipeline {
    agent any
    environment {
        // Replace 'your_image_registry' with your Docker registry (e.g., 'docker.io', 'gcr.io', etc.)
        // Replace 'your_image_name' with your Docker image name (e.g., 'java-microservice')
        DOCKER_IMAGE = "karthikeya964/java-microservice"
        DOCKER_TAG = "latest"
        K8S_NAMESPACE = "default"
    }
    stages {
        stage('Build') {
            steps {
                script {
                    // Build Java application using Maven
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
                    // Build Docker image from Dockerfile
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
                    // Push Docker image to your Docker registry
                    sh 'docker push $DOCKER_IMAGE:$DOCKER_TAG'
                }
            }
        }
        stage('Deploy to Kubernetes') {
            when {
                branch 'develop'
            }
            steps {
                script {
                    // Apply Kubernetes manifests for deployment
                    // Make sure kubernetes/deployment.yaml and kubernetes/service.yaml exist and are correctly configured
                    sh 'kubectl apply -f kubernetes/deployment.yaml'
                    sh 'kubectl apply -f kubernetes/service.yaml'
                }
            }
        }
    }
}
