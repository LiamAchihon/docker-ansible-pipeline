pipeline {
  agent any

  environment {
    DOCKERHUB_USER = 'liamachihon'
    DOCKERHUB_PASS = credentials('dockerhub-creds')
  }

  stages {
    stage('Clone Repo') {
      steps {
        checkout scm
      }
    }

    stage('Build Docker Image') {
      steps {
        sh 'docker build -t $DOCKERHUB_USER/hello-liam:latest .'
      }
    }

    stage('Push to DockerHub') {
      steps {
        withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKERHUB_USER', passwordVariable: 'DOCKERHUB_PASS')]) {
          sh """
            echo $DOCKERHUB_PASS | docker login -u $DOCKERHUB_USER --password-stdin
            docker push $DOCKERHUB_USER/hello-liam:latest
          """
        }
      }
    }

    stage('Fix SSH Known Hosts') {
      steps {
        sh 'mkdir -p ~/.ssh && touch ~/.ssh/known_hosts'
      }
    }

    stage('Deploy with Ansible') {
      steps {
        sh 'ansible-playbook -i inventory deploy-playbook.yml'
      }
    }
  }
}



