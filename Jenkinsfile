pipeline {
    agent any
    environment {
        IMAGE = "YOUR_DOCKERHUB_USER/myapp:${BUILD_NUMBER}"
    }
    stages {
        stage('Build Image') {
            steps {
                sh 'docker build -t $IMAGE .'
            }
        }
        stage('Push Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub',
                    usernameVariable: 'U', passwordVariable: 'P')]) {
                    sh 'echo $P | docker login -u $U --password-stdin'
                    sh 'docker push $IMAGE'
                }
            }
        }
        stage('Deploy to K8s') {
            steps {
                withCredentials([file(credentialsId: 'kubeconfig', variable: 'KUBECONFIG')]) {
                    sh 'sed -i "s|image:.*|image: $IMAGE|" k8s/Deployment.yaml'
                    sh 'kubectl apply -f k8s/'
                    sh 'kubectl rollout status deployment/myapp'
                }
            }
        }
    }
}
