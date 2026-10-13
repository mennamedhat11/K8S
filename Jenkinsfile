pipeline {
    agent any
    environment {
        IMAGE = "mennamedhat123/myapp:${BUILD_NUMBER}"
    }
    stages {
        stage('Build Image') {
            steps {
                sh 'docker build -t $IMAGE .'
            }
        }
        stage('Push Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'Docker',
                    usernameVariable: 'U', passwordVariable: 'P')]) {
                    sh 'echo "$P" | docker login -u "$U" --password-stdin'
                    sh 'docker push $IMAGE'
                }
            }
        }
        stage('Deploy to K8s') {
            steps {
                withCredentials([file(credentialsId: 'kubeconfig', variable: 'KUBECONFIG')]) {
                    sh 'sed -i "s|image:.*|image: $IMAGE|" K8S/Deployment.yaml'
                    sh 'kubectl apply -f K8S/'
                    sh 'kubectl rollout status deployment/myapp --timeout=120s'
                }
            }
        }
    }
}
