pipeline {
    agent { 
        label 'docker'
    }
    tools {
        maven 'maven3'
        jdk 'java17'
    }
    environment {
        App_name = "My_App"
        RELEASE = "1.0.0"
        Docker_User = "starkdocker475"
        Docker_Pass = 'docker_hub credentials'  // Using Jenkins credentials store
        Image_name = "${Docker_User}/${App_name}"  // Concatenating strings properly
        Image_tag = "${RELEASE}-${BUILD_NUMBER}"  // Correcting the variable for build number
    }
    stages {
        stage('Clean workspace') {
            steps {
                cleanWs()  // Cleaning workspace
            }
        }
        stage('Git Checkout') {
            steps {
                git branch: 'main', credentialsId: 'git-token', url: 'https://github.com/Stark-Repo/Jenkins.git'
            }
        }
        stage('Build with Maven') {
            steps {
                sh 'mvn clean package'
            }
        }
        stage('Test with Maven') {
            steps {
                sh 'mvn test'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image
                    withDockerRegistry([credentialsId: 'docker-hub-credentials']) {
                        docker_image = docker.build("${Image_name}:${Image_tag}")
                    }
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                script {
                    // Push the Docker image with tag and latest
                    withDockerRegistry([credentialsId: 'docker-hub-credentials']) {
                        docker_image.push("${Image_tag}")
                        docker_image.push('latest')
                    }
                }
            }
        }
    }
    post {
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed.'
        }
    }
}
