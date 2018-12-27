pipeline {
    agent any

    stages {
        stage('Preparation') {
            steps {
               git branch: 'master', url: 'https://github.com/SPECCHIODB/VM_Appliance.git'
               sh 'rm -rf output-virtualbox-iso/'
            }
        }
        stage('Build') {
            steps {
                sh '/usr/local/bin/packer build -var "bridge_adapter=eth0" templates/specchio_centos7.6_virtualbox.json'
            }
        }
        stage('Upload Archive') {
            steps {
                archiveArtifacts artifacts: 'output-virtualbox-iso/*.ova', fingerprint: true
            }
        }
    }
}
