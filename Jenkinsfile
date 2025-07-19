pipeline {
  agent any

  environment {
    IMAGE_NAME = 'liamachihon/hello-liam'
    VERSION = 'latest'
  }

  stages {
    stage('Build Docker Image') {
      steps {
        script {
          sh 'docker build -t $IMAGE_NAME:$VERSION .'
        }
      }
    }

    stage('Push to DockerHub') {
      steps {
        withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', passwordVariable: 'DOCKER_PASS', usernameVariable: 'DOCKER_USER')]) {
          script {
            sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
            sh 'docker push $IMAGE_NAME:$VERSION'
          }
        }
      }
    }

    stage('Deploy with Ansible') {
      steps {
        sh 'ansible-playbook -i "your-server-ip," -u ec2-user --private-key ~/path/to/liam-key.pem deploy-playbook.yml'
      }
    }
  }
}
