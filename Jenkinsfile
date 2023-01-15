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
        stage('SonarQube analysis') {
          node {
              withSonarQubeEnv('SonarQube Analysis') {
                 sh 'mvn clean package sonar:sonar'
              }
          }
      }

      stage("Quality Gate"){
          timeout(time: 1, unit: 'HOURS') {
              def qg = waitForQualityGate()
              if (qg.status != 'OK') {
                  error "Pipeline aborted due to quality gate failure: ${qg.status}"
              }
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
         stage('Select Environment to Deploy') {
             steps {
              script {
                env.selected_environment = input  message: 'Select environment to Deploy',ok : 'Proceed',id :'tag_id',
                parameters:[choice(choices: ['DEV', 'STAGE', 'PROD'], description: 'Select environment', name: 'env')]
                echo "Deploying in ${env.selected_environment}."
            }
         }
      }
       stage('Dev Deploy'){
            steps{
                script{
                    sh 'kubectl apply -f /Users/shaikfahemida/desktop/springboot-firstapp/deploymentservice.yaml'
                }
            }
        }
        stage('Stage Deploy'){
            steps{
                script{
                    sh 'kubectl apply -f /Users/shaikfahemida/desktop/springboot-firstapp/deploymentservice.yaml'
                }
            }
        }
        stage('Prod Deploy'){
            steps{
                script{
                    sh 'kubectl apply -f /Users/shaikfahemida/desktop/springboot-firstapp/deploymentservice.yaml'
                }
            }
        }
    }
}
