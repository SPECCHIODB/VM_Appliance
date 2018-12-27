pipeline {
    agent any

    stages {
        stage('Preparation') {
            steps {
               git branch: 'master', url: 'https://github.com/SPECCHIODB/VM_Appliance.git'
            }
        }
        stage('Build') {
            steps {
                sh 'packer build -var "bridge_adapter=eth0" templates/specchio_centos7.6_virtualbox.json'
            }
        }
        stage('Upload Archive') {
            steps {
                archiveArtifacts artifacts: 'output-virtualbox-iso/*.ova', fingerprint: true
            }
        }
    }
}
