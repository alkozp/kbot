pipeline {
    agent any
    environment {
        REPO = 'https://github.com/alkozp/kbot'
        BRANCH = 'main'
    }
    parameters {
        choice(name: 'OS', choices: ['linux', 'darwin', 'windows', 'all'], description: 'Pick OS')
        choice(name: 'ARCH', choices: ['amd64', 'arm64', 'all'], description: 'Pick ARCH')
    }

    stages {

        stage("clone") {
            steps {
              echo 'CLONE REPOSITORY'
              git branch: "${BRANCH}", url: "${REPO}"
            }
        }

        stage("test") {
            steps {
              echo 'TEST EXECUTION STARTED'
              sh 'make test'
            }
        }

        stage("build") {
            steps {
                script {
                    echo 'BUILD EXECUTION STARTED'
                    echo "Build for platform ${params.OS}"
                    echo "Build for platform ${params.ARCH}"
                    if ((params.OS.contains('linux')) || (params.OS.contains('all'))) {
                        if ((params.ARCH.contains('amd64')) || (params.ARCH.contains('all'))){
                            sh 'make linux amd64'
                        }
                        if ((params.ARCH.contains('arm64')) || (params.ARCH.contains('all'))){
                            sh 'make linux arm64'
                        } 
                    } 
                    if ((params.OS.contains('darwin')) || (params.OS.contains('all'))) {
                        if ((params.ARCH.contains('amd64')) || (params.ARCH.contains('all'))){
                            sh 'make darwin amd64'
                        }
                        if ((params.ARCH.contains('arm64')) || (params.ARCH.contains('all'))){
                            sh 'make darwin arm64'
                        } 
                    }
                    if ((params.OS.contains('windows')) || (params.OS.contains('all'))) {
                        if ((params.ARCH.contains('amd64')) || (params.ARCH.contains('all'))){
                            sh 'make windows amd64'
                        }
                        if ((params.ARCH.contains('arm64')) || (params.ARCH.contains('all'))){
                            sh 'make windows arm64'
                        } 
                    }
                }
            }
        }

        stage("image") {
            steps {
                script {
                    echo 'BUILD IMAGE EXECUTION STARTED'
                    sh 'make image'
                }
            }
        }

        stage("push") {
            steps {
                script {
                    docker.withRegistry( '', 'dockerhub') {
                    sh 'make push'
                    }
                }
            }
        }


    }
}

