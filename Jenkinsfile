pipeline {
  environment {
    registry = "dogbern/demoapp"
    registryCredential = 'dockerhub'
    dockerImage = ''
  }
  agent any
  
  stages {
    stage('Cloning Git') {
      steps {
        git credentialsId: 'github', url: 'https://github.com/dogbern/cloud-native-demo.git'
      }
    }
    
    stage('Lint') {
      steps {
        sh 'hadolint --ignore DL3013 $WORKSPACE/Dockerfile'
      }
    }

    stage('Build Image') {
      steps {
        script {
          dockerImage = docker.build registry + ":$BUILD_NUMBER"
        }
      }
    }

    stage('Push Image') {
      steps {
        script {
          withDockerRegistry(registry: [credentialsId: registryCredential]) {
            dockerImage.push('latest')
          }       
        }
      }
    }

    stage('Remove Image from Jenkins') {
      steps {
          sh "docker rmi $registry:$BUILD_NUMBER"
          sh "docker rmi $registry:latest"
      }
    }
    
    stage('Deploy Demo Container') {
      steps {
        sh 'kubectl apply -f $WORKSPACE/kubernetes/app.yaml'
      }
    }

    stage('Edit DNS record set to point to the app service') {
      steps {
        sh 'aws route53 change-resource-record-sets --hosted-zone-id Z047210437EDQ22T6THSN --change-batch file://$WORKSPACE/kubernetes/change_res_record_set.json'
      }
    }
  }
}
