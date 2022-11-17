pipeline {
         agent any
         tools {
                   maven 'M3'
		   jdk 'jdk8'
         }
        
	stages {
    		stage('Build') 	{
			steps {
        			sh '''
				java -version
				mvn clean package
				'''
			}
    		}
    		stage('parallel stages') {
    		        parallel {
    			        stage('Archival') {
				        steps {
        				        archiveArtifacts 'target/*.war'
				        }
    			        }
		
			        stage('Test cases') {
				        steps {
        				        junit 'target/surefire-reports/*.xml'
				        }
    		                }
		        } 
                }
		stage('Build Image') {
                	steps {
                		sh '''
                    			docker build --no-cache -t clinicforpets:latest .
                    			docker tag clinicforpets:latest bharadwaja1998/clinicforpets-image:v${BUILD_NUMBER}
                		'''
            		}
        	}

        stage('Push Image') {
            steps {
		withCredentials([usernamePassword(credentialsId: 'dockerhub', passwordVariable: 'PASS', usernameVariable: 'USER')]) {
                	sh '''
                    		docker login --username $USER --password $PASS
                    		docker push bharadwaja1998/clinicforpets-image:v${BUILD_NUMBER}
                	'''
		}
            }
        }

  	}
	post {
		always {
			notify('started')
		}
		failure {
			notify('err')
		}
		success {
			notify('success')
		}
	}
}

def notify(status){
    emailext (
    to: "saibharadwaja@gmail.com",
    subject: "${status}: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'",
    body: """<p>${status}: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]':</p>
        <p>Check console output at <a href='${env.BUILD_URL}'>${env.JOB_NAME}  [${env.BUILD_NUMBER}]</a></p>""",
    )
 }
