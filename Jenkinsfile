pipeline {
    agent any
	environment {
	  DOCKERHUB_USER = 'gabrieljoe'
	  DOCKERHUB_PASSWORD = 'pF2KSDEbAbDyBGT'
	  DOCKERHUB_REPOSITORY = 'gabrieljoe'
	  DOCKER_VERSION = sh(returnStdout: true, script: """ echo \$(xmllint --xpath '/*[local-name()="project"]/*[local-name()="properties"]/*[local-name()="docker-version"]/text()' pom.xml) """)
	  APP_VERSION = sh(returnStdout: true, script: """ echo \$(xmllint --xpath '/*[local-name()="project"]/*[local-name()="version"]/text()' pom.xml) """)
	}
    stages {
		stage('Compile') {
            steps {
                echo 'Compile'
                sh 'mvn clean compile'
            }
        }
        stage('Build') {
            steps {
                echo 'Clean/Build'
                sh 'mvn clean install'
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
				echo 'Deploy'
                sh 'echo $DOCKERHUB_PASSWORD | docker login -u $DOCKERHUB_USER --password-stdin'
				sh 'docker build . -t $DOCKERHUB_REPOSITORY/spring-petclinic:$DOCKER_VERSION'
                sh 'docker push $DOCKERHUB_REPOSITORY/spring-petclinic:$DOCKER_VERSION'
            }
        }
    }    
    post {
        always {
            echo 'JENKINS PIPELINE'
        }
        success {
            echo 'JENKINS PIPELINE SUCCESSFUL'
			deleteDir()
        }
        failure {
            echo 'JENKINS PIPELINE FAILED'
			deleteDir()
        }
        unstable {
            echo 'JENKINS PIPELINE WAS MARKED AS UNSTABLE'
        }
        changed {
            echo 'JENKINS PIPELINE STATUS HAS CHANGED SINCE LAST EXECUTION'
        }
    }
}