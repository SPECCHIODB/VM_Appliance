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
		    certificate(credentialsId: 'specchio_trust',
				keystoreVariable: 'SPECCHIO_KEYSTORE',
				aliasVariable: 'SPECCHIO_KEYSTORE_ALIAS',
				passwordVariable: 'SPECCHIO_KEYSTORE_PASSWORD'),
		    string(credentialsId: 'specchio_db_password',
			   variable: 'SPECCHIO_PASSWORD')])
		{
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
