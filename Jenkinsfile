currentBuild.displayName = "online-shopping-#"+currentBuild.number
pipeline{
    agent any
    environment{
        PATH = "/opt/maven/bin:$PATH"
    }
    stages{
        stage("Git checkput"){
            steps{
                git credentialsId: 'github', url: 'https://github.com/devopsdemo1990/DevopsBasics'
            }
        }
        stage("maven build"){
            steps{
                sh "mvn clean package"
            }
        }
        stage("deploy-dev"){
            steps{
               sshagent(['tomcat']) {
                   sh """ 
                      scp -o StrictHostKeyChecking=no  /var/lib/jenkins/workspace/test/webapp/target/webapp.war  ec2-user@3.20.235.106:/opt/tomcat8/webapps/

                      ssh ec2-user@3.20.235.106 /opt/tomcat8/bin/shutdown.sh
        
                      ssh ec2-user@3.20.235.106 /opt/tomcat8/bin/shutdown.sh
    
                   """
                }
            
            }
        }
    }
}
