currentBuild.displayName = "pipeline-project1-#"+currentBuild.number
pipeline{
    agent any
    environment{
        PATH = "/opt/maven/bin:$PATH"
        DOCKER_TAG = getDockerTag()
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
        stage("transfer-war"){
            steps{
              sshPublisher(publishers: [sshPublisherDesc(configName: 'docker', transfers: [sshTransfer(cleanRemote: false, excludes: '', execCommand: '', execTimeout: 120000, flatten: false, makeEmptyDirs: false, noDefaultExcludes: false, patternSeparator: '[, ]+', remoteDirectory: '.', remoteDirectorySDF: false, removePrefix: 'webapp/target/', sourceFiles: 'webapp/target/*.war')], usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: false)])
            
            }
        }
     
        stage("build docker"){
            steps{
               sshagent(['docker']) {
                 sh ''' 
                    scp -o StrictHostKeyChecking=no  /var/lib/jenkins/workspace/test/Dockerfile  root@18.224.229.64:/root

                    scp -o StrictHostKeyChecking=no  /var/lib/jenkins/workspace/test/pods.yml  root@18.224.229.64:/root

                    scp -o StrictHostKeyChecking=no  /var/lib/jenkins/workspace/test/services.yml  root@18.224.229.64:/root
                   
                    ssh -o StrictHostKeyChecking=no root@18.224.229.64  sudo docker build . -t firstapp:$DOCKER_TAG 
                    
                    '''             
               }

            }
            
        }
    }
}
def getDockerTag(){
    def tag = sh script:'git rev-parse HEAD', returnStdout: true
    return tag
}
