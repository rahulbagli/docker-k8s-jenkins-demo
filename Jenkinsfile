pipeline{
  agent any
     tools {
          maven "Local Maven"
      }
     environment {
         dockerImage = ''
         KUBECONFIG = credentials('k8sconfigid')
     }
      stages{
       stage('SCM Checkout'){
        steps{
          git 'https://github.com/rahulbagli/docker-k8s-jenkins-demo'
        }
      }
      stage('Build and Install'){
         steps{
               bat 'mvn clean compile'
               bat 'mvn install'
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

      stage('Setup Kubectl') {
              steps {
                  script {
                      // Set KUBECONFIG environment variable to the path of the kubeconfig file
                      bat "set KUBECONFIG=%KUBECONFIG_PATH%"
                      // Verify the KUBECONFIG environment variable
                      bat 'echo %KUBECONFIG%'
                      // Verify the context
                      bat 'kubectl config use-context docker-desktop'
                      // Print the current context to verify kubeconfig usage
                      bat 'kubectl config current-context'
                  }
              }
      }
       stage('Deploy to Kubernetes') {
            steps {
               script {
                     def deploymentFile = 'deployment.yaml'
                     def serviceFile = 'service.yaml'

                     // Apply the deployment and service files
                     try {
                         bat "kubectl apply -f ${deploymentFile}"
                         bat "kubectl apply -f ${serviceFile}"
                     } catch (err) {
                         echo "Error during deployment: ${err}"
                     }
                 }
              }
          }
 }
  post {
     always {
       cleanWs()
     }
     success {
       echo 'Deployment Successful!'
     }
     failure {
       echo 'Deployment Failed!'
     }
   }
}
