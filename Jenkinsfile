pipeline {
    agent any
    tools{
        maven 'M3' 
    }
    stages{
        stage('Build Maven'){
            steps{
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/rafi13us/devops-automation']])
                sh 'mvn clean install'
                
            }
        }
        stage('Build docker image'){
            steps{
                script{
                    sh 'docker build -t mohammedrafishaik71/devops-automation .'
                }
            }
        }
        stage('login to dockerHUB'){
            steps{
                script{
                    withCredentials([string(credentialsId: 'mohammedrafishaik71', variable: 'dockerhubpwd')]) {
                    sh 'docker login -u mohammedrafishaik71 -p ${dockerhubpwd}'
                    }
                    sh 'docker push mohammedrafishaik71/devops-automation'
                }
            }
        }
       stage('Dev Deploy'){
            steps{
                script{
                    sh 'kubectl apply -f deploymentservice.yaml'
                }
            }
        }
        stage('Stage Deploy'){
            steps{
                script{
                    sh 'kubectl apply -f deploymentservice.yaml'
                }
            }
        }
        stage('Prod Deploy'){
            steps{
                script{
                    sh 'kubectl apply -f deploymentservice.yaml'
                }
            }
        }
    }
}
