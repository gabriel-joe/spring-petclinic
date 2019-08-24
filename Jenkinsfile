pipeline {
    agent any
	environment {
	  NEXUS_HOST = '192.168.99.100:8081'
	  SONAR_HOST = 'http://192.168.99.100:9000'
	  NEXUS_USER = 'admin'
	  NEXUS_PASSWOD = 'gabriel12'
	  DOCKER_VERSION = '2.1.0'
	  APP_VERSION = sh """ export APP_VERSION=\$(xmllint --xpath '/*[local-name()="project"]/*[local-name()="version"]/text()' pom.xml) """
	}
    stages {
        stage('Build') {
            steps {
                echo 'Clean/Build'
				echo '$APP_VERSION'
                sh 'mvn clean compile'
            }
        }
        stage('Test') {
            steps {
                echo 'Testing'
                sh 'mvn test'
            }
        }
        stage('publish-jar') {
            steps {
                sh 'mvn --settings settings.xml deploy'
            }
        }
        stage('Deploy') {
            steps {
                sh 'echo $NEXUS_PASSWORD | docker login -u $NEXUS_USER --password-stdin $NEXUS_HOST'
				sh 'docker build . -t $NEXUS_HOST/spring-petclinic:$DOCKER_VERSION'
                sh 'docker push $NEXUS_HOST/spring-petclinic:$DOCKER_VERSION'
            }
        }
    }    
    post {
        always {
            echo 'JENKINS PIPELINE'
        }
        success {
            echo 'JENKINS PIPELINE SUCCESSFUL'
        }
        failure {
            echo 'JENKINS PIPELINE FAILED'
        }
        unstable {
            echo 'JENKINS PIPELINE WAS MARKED AS UNSTABLE'
        }
        changed {
            echo 'JENKINS PIPELINE STATUS HAS CHANGED SINCE LAST EXECUTION'
        }
    }
}