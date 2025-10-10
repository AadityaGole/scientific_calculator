pipeline {
    agent any

    environment {
        DOCKERHUB_USER = 'aadityag'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/AadityaGole/scientific_calculator.git'
            }
        }

        stage('Test') {
            steps {
                bat 'python -m unittest discover -s tests -p "test_*.py" -v'
            }
        }

        stage('Build Docker Image') {
            steps {
                bat 'docker build -t %DOCKERHUB_USER%/scientific-calculator:dev .'
            }
        }

        stage('Push Docker Image') {
            steps {
                withCredentials([string(credentialsId: 'docker-hub-token', variable: 'DOCKER_PASSWORD')]) {
                    bat 'docker login -u %DOCKERHUB_USER% -p %DOCKER_PASSWORD%'
                    bat 'docker tag %DOCKERHUB_USER%/scientific-calculator:dev %DOCKERHUB_USER%/scientific-calculator:latest'
                    bat 'docker push %DOCKERHUB_USER%/scientific-calculator:latest'
                }
            }
        }

        stage('Deploy via Ansible') {
            steps {
                bat 'wsl ansible-playbook -i /mnt/c/Users/aadit/work/clg/spe/scientific_calculator/hosts.ini /mnt/c/Users/aadit/work/clg/spe/scientific_calculator/deploy_calculator.yml'
            }
        }
    }
}
