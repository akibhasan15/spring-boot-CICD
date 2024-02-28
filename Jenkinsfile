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
}}