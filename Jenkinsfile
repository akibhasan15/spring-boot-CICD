pipeline {
    agent any

    tools {
        // Install the Maven version configured as "Maven3" and JDK17.
        maven "Maven3"
        jdk "JDK17"
    }

    stages {
        stage('Test') {
            steps {
                // Get the code from a GitHub repository

       git branch: 'main', url: 'https://github.com/akibhasan15/spring-boot-CICD'

                // Run Maven on a Unix agent.
                sh "mvn -Dmaven.test.failure.ignore=true clean package"

                // To run Maven on a Windows agent, use
               // bat "mvn -Dmaven.test.failure.ignore=true clean package"
            }

        }


       stage('Build-and-Push') {
        environment{
                   tag = sh(script: 'git describe --abbrev=0', returnStdout: true).trim()
               }
    steps{
     script{

        withDockerRegistry([ credentialsId: "dockerhub", url: "" ]) {
        docker.build("akib123/spring-boot:${tag}","-f ./Dockerfile ./").push()

                                                                      }
            }
          }
    }


#####DEPLOY
 stage('Deploy') {
           environment{
                             tag = sh(script: 'git describe --abbrev=0', returnStdout: true).trim()
                         }
            steps{

               sshagent(credentials: ['k8sCluster']) {
               withCredentials([string(credentialsId: 'USER-KubeServer', variable: 'userAtIP')]) {

                sh 'scp ./deploy/app1.yaml .deploy/service.yaml   ${userAtIP}: '
                sh 'ssh ${userAtIP} "export IMAGE_TAG=${tag} "'
                sh 'ssh ${userAtIP} "envsubst < app1.yaml | minikube kubectl apply -f -"'
                sh 'ssh ${userAtIP} "minikube kubectl -- apply -f service.yaml"'
                sh 'ssh ${userAtIP} "rm ./app1.yaml ./service.yaml"'
}



    }
            }
    }
######DEPLOY-ENDED-HERE


}

}