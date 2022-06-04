pipeline {
    agent any

    stages {
        stage ('Checkout') {
            steps {
                script {
                    checkout([$class             : 'GitSCM'
                              , branches         : [[name: "main"]]
                              , userRemoteConfigs: [[credentialsId: 'hoseong-gh', url: 'https://github.com/Youhoseong/jenkins-pipeline.git']]])
                }
            }
        }


        stage('Build') {
            steps {
                script {
                    sh '''
                        ./gradlew :ui:clean :ui:bootJar
                    '''
                }

            }
        }

        stage('Docker Push') {
            steps {
                script {
                    sh ''' 
                        cd ui/
                        docker build -t youhoseong/${PJ_NAME} .
                        docker push youhoseong/${PJ_NAME}
                    '''
                }
            }
        }

        stage('SSH transfer') {
            steps {
                script {
                    sshPublisher (
                            continueOnError: false, failOnError: true,
                            publishers: [
                                    sshPublisherDesc(
                                            configName: "deploy-server",
                                            verbose: true,
                                            transfers: [
                                                    sshTransfer(
                                                            sourceFiles: "${PJ_NAME}/build/libs/*.jar",
                                                            removePrefix: "${PJ_NAME}/build/libs",
                                                            execCommand: "sh ./scripts/deploy.sh"
                                                    )
                                            ])
                            ])
                }
            }
        }

    }

    post {
        success {
            echo 'Success !!'
        }
        failure {
            echo 'Fail ..'
        }
    }
}
