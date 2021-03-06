pipeline {
  environment {
    registry = "dogbern/demoapp"
    registryCredential = 'dockerhub'
    aws_cred = 'aws_cred'
    dockerImage = ''
  }
  agent any
  
  stages {
    stage('Cloning Git') {
      steps {
        git 'https://github.com/dogbern/cloud-native-demo.git'
      }
    }
    
    stage('Lint Dockerfile') {
      steps {
        sh 'docker run --rm -i hadolint/hadolint < $WORKSPACE/Dockerfile'
      }
    }

    stage('Build Docker Image') {
      steps {
        script {
          dockerImage = docker.build registry + ":$BUILD_NUMBER"
        }
      }
    }

    stage('Push Docker Image') {
      steps {
        script {
          withDockerRegistry(registry: [credentialsId: registryCredential]) {
            dockerImage.push('latest')
            dockerImage.push("$BUILD_NUMBER")
          }       
        }
      }
    }
    
    stage('Deploy Container to EKS Cluster') {
      steps {
        sh "sed -i 's/demoapp:latest/demoapp:$BUILD_NUMBER/g' $WORKSPACE/kubernetes/app.yaml"
        sh '/var/lib/jenkins/bin/kubectl apply -f $WORKSPACE/kubernetes/app.yaml'
      }
    }
    
    stage('Route app service to www.bambouktu.com') {
      steps {
        withAWS(credentials: aws_cred, region: 'us-east-2') {
          sh 'aws route53 change-resource-record-sets --hosted-zone-id Z047210437EDQ22T6THSN --change-batch file://$WORKSPACE/kubernetes/change_res_record_set.json'
        }
      }
    }
  }
}
