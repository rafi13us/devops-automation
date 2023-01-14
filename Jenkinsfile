
pipeline {
    agent any

    tools {
        // Install the Maven version configured as "M3" and add it to the path.
        maven "M3"
    }
    environment {
    		DOCKERHUB_CREDENTIALS=credentials('dockerhubcredentials')
    	}

    stages {
        stage('Build') {
            steps {
                // Get some code from a GitHub repository
                git branch: 'main', url: 'https://github.com/rafi13us/devops-automation.git'

                // Run Maven on a Unix agent.
                withCredentials([string(credentialsId: 'SONAR_TOKEN', variable: 'SONAR_TOKEN')]) {
                    sh "mvn clean package verify org.sonarsource.scanner.maven:sonar-maven-plugin:sonar -Dsonar.projectKey=devopsautomation"
                    sh "mvn -Dmaven.test.failure.ignore=true clean package"
                } 
                sh "docker tag springio/gs-spring-boot-docker mohammedrafishaik71/devops-automation"
                //docker run -p 8080:8080 springio/gs-spring-boot-docker
                }

            post {
                // If Maven was able to run the tests, even if some of the test
                // failed, record the test results and archive the jar file.
                success {
                    junit '**/target/surefire-reports/TEST-*.xml'
                    archiveArtifacts 'target/*.jar'
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
        		}
        	}

        	post {
        		always {
        			sh 'docker logout'
        		}
        	}


    }
}
