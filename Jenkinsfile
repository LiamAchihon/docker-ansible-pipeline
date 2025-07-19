pipeline {
    agent any

    environment {
        DOCKERHUB_USER = 'liamachihon'
        DOCKERHUB_PASS = credentials('dockerhub-token')
    }

    stages {
        stage('Clone Repo') {
            steps {
                checkout([$class: 'GitSCM',
                    branches: [[name: '*/main']],
                    userRemoteConfigs: [[
                        url: 'https://github.com/LiamAchihon/docker-ansible-pipeline.git',
                        credentialsId: 'github-token'
                    ]]
                ])
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t ${DOCKERHUB_USER}/hello-liam:latest .'
            }
        }

        stage('Push to DockerHub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-token', passwordVariable: 'DOCKERHUB_PASS', usernameVariable: 'DOCKERHUB_USER')]) {
                    sh '''
                        echo $DOCKERHUB_PASS | docker login -u $DOCKERHUB_USER --password-stdin
                        docker push $DOCKERHUB_USER/hello-liam:latest
                    '''
                }
            }
        }

        stage('Deploy with Ansible') {
            steps {
                sh '''
                    ssh-keyscan -H 3.84.4.147 >> ~/.ssh/known_hosts
                    ansible-playbook -i inventory deploy-playbook.yml
                '''
            }
        }
    }
}

