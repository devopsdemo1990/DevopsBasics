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
                sh "mv target/*.war target/myweb.war"
            }
        }
        stage("deploy-dev"){
            steps{
                sshagent(['docker']){
                sh """
                   scp -o StrictHostKeyChecking=no target/myweb.war root@192.168.1.148:/opt/tomcat8/webapps/
                  
                   ssh root@192.168.1.148 /opt/tomcat8/bin/shutdown.sh
                  
                   ssh root@192.168.1.148 /opt/tomcat8/bin/startup.sh 
                """
                }
            
            }
        }
    }
}
