pipeline {
  agent any
  stages {
    stage('Create VM appliance') {
      steps {
        sh 'packer build templates/specchio_centos7.6_virtualbox.json'
      }
    }
  }
  post {
    always {
      archiveArtifacts artifacts: 'README.md'
    }
  }
}