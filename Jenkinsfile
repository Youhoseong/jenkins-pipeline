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
                        ./gradlew :${PJ_NAME}:clean :${PJ_NAME}:bootJar
                    '''
                }

            }
        }

//        stage('Docker Push') {
//            steps {
//                script {
//                    sh '''
//                        cd ${PJ_NAME}/
//                        docker build -t youhoseong/${PJ_NAME} .
//                        docker push youhoseong/${PJ_NAME}
//                    '''
//                }
//            }
//        }

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
                                                            sourceFiles: "scripts/deploy.sh"
                                                    ),
                                                    sshTransfer(
                                                            sourceFiles: "${PJ_NAME}/build/libs/*.jar",
                                                            removePrefix: "${PJ_NAME}/build/libs",
                                                            execCommand: "sh scripts/deploy.sh ${PJ_NAME} "
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
