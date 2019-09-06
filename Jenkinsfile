pipeline {
    agent any
	environment {
          HEROKU_APP = 'spring-pet'
          HEROKU_API_KEY = 'e1803e5e-2239-466c-838e-ba11ac43ea3f'
	  DOCKER_VERSION = sh(returnStdout: true, script: """ echo \$(xmllint --xpath '/*[local-name()="project"]/*[local-name()="properties"]/*[local-name()="docker-version"]/text()' pom.xml) """)
	  APP_VERSION = sh(returnStdout: true, script: """ echo \$(xmllint --xpath '/*[local-name()="project"]/*[local-name()="version"]/text()' pom.xml) """)
	}
    stages {
       stage('Compile') {
            steps {
                echo 'Compile'
                mvn 'clean compile'
            }
        }
        stage('Build') {
            steps {
                echo 'Clean/Build'
                mvn 'clean install -DskipTests=true -Dmaven.javadoc.skip=true -B -V'
            }
        }
        stage('Test') {
            steps {
                echo 'Testing'
                mvn 'test'
            }
        }
        stage('Deploy') {
            steps {
		echo 'Deploy to heroku'
                mvn 'heroku:deploy -DskipTests=true -Dmaven.javadoc.skip=true -B -V -D heroku.appName=${HEROKU_APP}'
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
