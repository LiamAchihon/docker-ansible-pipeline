pipeline {
  agent any

  environment {
    DOCKER_IMAGE = "liamachihon/hello-liam:latest"
  }

  stages {
    stage('Build Docker Image') {
      steps {
        sh 'docker build -t $DOCKER_IMAGE .'
      }
    }

    stage('Login to DockerHub & Push') {
      steps {
        withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
          sh '''
            echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin
            docker push $DOCKER_IMAGE
          '''
        }
      }
    }

    stage('Deploy with Ansible') {
      steps {
        sh 'ansible-playbook deploy-playbook.yml'
      }
    }
  }
}
