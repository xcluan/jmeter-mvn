pipeline {
    agent any

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
                sh "mvn clean verify -Dsuite.name=${SuiteName}"
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
