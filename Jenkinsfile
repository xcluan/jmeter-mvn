pipeline {
    agent any

    tools {
        // Install the Maven version configured as "M3" and add it to the path.
        maven "M3"
    }

    stages {
        stage('Pull Code') {
            steps {
                // Get some code from a GitHub repository
                git 'https://pd.zwc365.com/seturl/https://github.com/xcluan/jmeter-mvn.git'
            }
        }
        stage('Verify') {
            steps {
                // Run Maven on a Unix agent.
                sh "mvn clean verify"
            }

            post {
                // If Maven was able to run the tests, even if some of the test
                // failed, record the test results and archive the jar file.
                success {
                    sh "echo Commplet!!!!!!!!!!!"
                }
            }
        }
    }
}
