pipeline {
    agent any

    environment {
        DOCKERHUB_USER = credentials('dockerhub-username')
        DOCKERHUB_PASS = credentials('dockerhub-password')
    }

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
                withCredentials([usernamePassword(credentialsId: 'dockerhub-login', usernameVariable: 'DOCKERHUB_USER', passwordVariable: 'DOCKERHUB_PASS_PSW')]) {
                    sh '''
                        echo $DOCKERHUB_PASS_PSW | docker login -u $DOCKERHUB_USER --password-stdin
                        docker push liamachihon/hello-liam:latest
                    '''
                }
            }
        }

        stage('Fix SSH Known Hosts') {
            steps {
                sh '''
                    mkdir -p /var/lib/jenkins/.ssh
                    touch /var/lib/jenkins/.ssh/known_hosts
                    ssh-keyscan -H 3.84.4.147 >> /var/lib/jenkins/.ssh/known_hosts
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
