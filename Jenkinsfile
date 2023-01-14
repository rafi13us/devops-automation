
pipeline {
    agent any

    tools {
        maven "M3"
    }
    environment {
    		DOCKERHUB_CREDENTIALS=credentials('dockerhubcredentials')
    	}

    stages {
                stage('Prepare') {
                    steps {
                        git branch: 'main', url: 'https://github.com/rafi13us/devops-automation.git'    
                        withCredentials([string(credentialsId: 'SONAR_TOKEN', variable: 'SONAR_TOKEN')]) {
                                sh "mvn clean package verify org.sonarsource.scanner.maven:sonar-maven-plugin:sonar -Dsonar.projectKey=devopsautomation"
                                sh "mvn -Dmaven.test.failure.ignore=true clean package"
                        }       
                    }
                 }         
                stage('Build') {
        			    steps {
        				    sh "docker build -t mohammedrafishaik71/devops-automation:latest ."
                        }
        		}

        		stage('Login') {
        			steps {
        				sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
        			}
        		}
        		stage('Push') {
        			steps {
        				sh 'docker push mohammedrafishaik71/devops-automation:latest'
        			}
        	
        	        post {
        		        always {
        			       sh 'docker logout'
        		        }
        	        }
                }
         }
    }

