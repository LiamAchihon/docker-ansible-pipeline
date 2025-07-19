pipeline {
    agent any

    stages {
        stage('Clone Repo') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t liamachihon/hello-liam:latest .'
            }
        }

        stage('Push to DockerHub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-login', usernameVariable: 'DOCKERHUB_USER', passwordVariable: 'DOCKERHUB_PASS')]) {
                    sh '''
                        echo $DOCKERHUB_PASS | docker login -u $DOCKERHUB_USER --password-stdin
                        docker push liamachihon/hello-liam:latest
                    '''
                }
            }
        }

        stage('Fix SSH Known Hosts') {
            steps {
                sh '''
                    mkdir -p ~/.ssh
                    touch ~/.ssh/known_hosts
                    ssh-keyscan -H 3.84.4.147 >> ~/.ssh/known_hosts
                '''
            }
        }

        stage('Deploy with Ansible') {
            steps {
                sh 'ansible-playbook -i inventory deploy-playbook.yml'
            }
        }
    }
}
