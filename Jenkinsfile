pipeline {
    agent any

    environment {
        DOCKERHUB_USER = 'aadityag'
        IMAGE_NAME = 'scientific-calculator'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/<yourusername>/scientific_calculator.git'
            }
        }

        stage('Test') {
            steps {
                bat 'python -m unittest discover -s tests -p "test_*.py" -v'
            }
        }

        stage('Build Docker Image') {
            steps {
                bat 'docker build -t %DOCKERHUB_USER%/%IMAGE_NAME%:dev .'
            }
        }

        stage('Push Docker Image') {
            steps {
                bat 'docker login -u %DOCKERHUB_USER% -p <DOCKER_PASSWORD>'
                bat 'docker tag %DOCKERHUB_USER%/%IMAGE_NAME%:dev %DOCKERHUB_USER%/%IMAGE_NAME%:latest'
                bat 'docker push %DOCKERHUB_USER%/%IMAGE_NAME%:latest'
            }
        }

        stage('Deploy via Ansible') {
            steps {
                bat 'wsl ansible-playbook -i /mnt/c/Users/aadit/work/clg/spe/scientific_calculator/hosts.ini /mnt/c/Users/aadit/work/clg/spe/scientific_calculator/deploy_calculator.yml'
            }
        }
    }
}
