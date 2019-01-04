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
                withCredentials([
                    certificate(keystoreVariable: 'MY_KEYSTORE',
                        aliasVariable: 'KEYSTORE_ALIAS',
                        passwordVariable: 'KEYSTORE_PASSWORD',
                        credentialsId: 'specchio_trust')])
                {
                    sh 'echo $KEYSTORE_ALIAS $KEYSTORE_PASSWORD'
                    sh '/usr/local/bin/packer build -timestamp-ui templates/specchio_centos7.6_virtualbox.json'
                }
            }
        }
        stage('Upload Archive') {
            steps {
                archiveArtifacts artifacts: 'output-virtualbox-iso/*.ova', fingerprint: true
            }
        }
    }
}
