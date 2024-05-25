pipeline{
  agent any
 environment {
 dockerImage = ''
}
  stages{
   stage('SCM Checkout'){
    steps{
      git 'https://github.com/rahulbagli/docker-jenkins-maven-spring-boot'
    }
  }
  stage('Compile package'){
     steps{
   sh 'mvn clean compile'
     }
  }
  stage('Build and Install'){
     steps{
   sh 'mvn install'
     }
  }
  stage('Docker build'){
   steps{
       script {
          dockerImage = docker.build "rahulbagli/docker-k8s-jenkins-demo:latest"
        }
   }
  }
  stage('Docker push') {
     steps {
         script {
          docker.withRegistry("https://registry.hub.docker.com", "docker-hub-credentials") {
          dockerImage.push()
      }
    }
     }
  }
 stage('Deploy and run docker image') {
     steps {
          sh "docker run -p 9090:8080 rahulbagli/docker-k8s-jenkins-demo"
     }
 }
 }
}
