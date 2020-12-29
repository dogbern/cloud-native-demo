pipeline {
  environment {
    registry = "dogbern/demoapp"
    registryCredential = 'dockerhub'
    aws_cred = 'aws_cred'
    kube = 'kube'
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
          }       
        }
      }
    }

    stage('Delete build images from Jenkins') {
      steps {
        sh "docker rmi $registry:$BUILD_NUMBER"
        sh "docker rmi $registry:latest"
      }
    }
    
    stage('Deploy Container to EKS Cluster') {
      steps {
        //withCredentials([kubeconfigContent(credentialsId: kube, variable: 'KUBECONFIG_CONTENT')]) {
          //sh '''echo "$KUBECONFIG_CONTENT" > kubeconfig && cat kubeconfig && rm kubeconfig'''
        //}
        kubernetesDeploy(kubeconfigId: kube, configs: '$WORKSPACE/kubernetes/*')
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
