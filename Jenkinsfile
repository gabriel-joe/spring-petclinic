pipeline {
    agent any
	environment {
	  DOCKERHUB_USER = 'gabrieljoe'
	  DOCKERHUB_PASSWORD = 'pF2KSDEbAbDyBGT'
	  DOCKER_VERSION = sh(returnStdout: true, script: """ echo \$(xmllint --xpath '/*[local-name()="project"]/*[local-name()="properties"]/*[local-name()="docker-version"]/text()' pom.xml) """)
	  APP_VERSION = sh(returnStdout: true, script: """ echo \$(xmllint --xpath '/*[local-name()="project"]/*[local-name()="version"]/text()' pom.xml) """)
	}
    stages {
        stage('Build') {
            steps {
                echo 'Clean/Build'
				sh 'echo $APP_VERSION'
				sh 'echo $DOCKER_VERSION'
                sh 'mvn clean compile'
            }
        }
        stage('Test') {
            steps {
                echo 'Testing'
                sh 'mvn test'
            }
        }
        stage('Deploy') {
            steps {
                sh 'echo $DOCKERHUB_PASSWORD | docker login -u $DOCKERHUB_USER --password-stdin'
				sh 'docker build . -t $DOCKERHUB_USER/spring-petclinic:$DOCKER_VERSION'
                sh 'docker push $DOCKERHUB_USER/spring-petclinic:$DOCKER_VERSION'
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