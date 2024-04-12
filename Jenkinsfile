pipeline {
    agent {
        docker {
            image 'buggavep/sample-devops:1.0'
            args '-v /var/run/docker.sock:/var/run/docker.sock'
        }
    }
    
    stages {
        stage('Build') {
            steps {
                sh 'javac HelloWorld.java'
            }
        }
        
        stage('Package') {
            steps {
                sh 'docker build -f Dockerfile-8u131 -t buggavep/hello-world .'
            }
        }
        
        // stage('Push') {
        //     steps {
        //         withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
        //             sh 'docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD'
        //             sh 'docker tag hello-world your-dockerhub-username/hello-world:latest'
        //             sh 'docker push your-dockerhub-username/hello-world:latest'
        //         }
        //     }
        // }
    }
}