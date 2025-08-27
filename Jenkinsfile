// pipeline {
//     agent any

//     environment {
//         DOCKER_REPO = credentials('docker-hub-creds')
      
//         // RENDER_HOOK = credentials('render-hook')
//         IMAGE_NAME = 'rafaydevsinc/insta-clone1'
//     }

//     stages {
//         stage('Checkout') {
//             steps {
//                 git branch: 'main', url: 'https://github.com/Rafay-devsinc/insta-clone-1042-main.git'

//             }
//         }

//         stage('Docker Build') {
//             steps {
//                 sh "docker build -t $IMAGE_NAME:latest ."
//             }
//         }

//         stage('Docker Login') {
//             steps {
//                 sh "echo $DOCKER_REPO_PSW | docker login -u $DOCKER_REPO_USR --password-stdin"
//             }
//         }

//         stage('Push to Docker Hub') {
//             steps {
//                 sh "docker push $IMAGE_NAME:latest"
//             }
//         }

        
//         // stage('Trigger Render Deploy') {
//         //     steps {
//         //         sh "curl -X POST $RENDER_HOOK"
//         //     }
//         // }
//     }
// }





// pipeline {
//     agent any

  

//     environment {
//         DOCKER_REPO = credentials('docker-hub-creds')
//         IMAGE_NAME = 'rafaydevsinc/insta-clone1'
//         CONTAINER_NAME = 'insta-clone-app'
//     }

//     stages {
//         stage('Checkout') {
//             steps {
//                 git branch: 'main', url: 'https://github.com/Rafay-devsinc/insta-clone-1042-main.git'
//             }
//         }

//         stage('Docker Build') {
//             steps {
//                 sh "docker build -t $IMAGE_NAME:latest ."
//             }
//         }

//         stage('Docker Login') {
//             steps {
//                 sh "echo $DOCKER_REPO_PSW | docker login -u $DOCKER_REPO_USR --password-stdin"
//             }
//         }

//         stage('Push to Docker Hub') {
//             steps {
//                 sh "docker push $IMAGE_NAME:latest"
//             }
//         }

//         stage('Deploy Latest Container') {
//             steps {
//                 // script {
                    
//                     sh """
//                         docker stop $CONTAINER_NAME || true
//                         docker rm $CONTAINER_NAME || true
//                     """

                   
//                     sh "docker pull $IMAGE_NAME:latest"

                    
//                     sh """
//                         docker run -d --name $CONTAINER_NAME -p 3000:3000 $IMAGE_NAME:latest
//                     """
//                 // }
//             }
//         }
//     }
// }





pipeline {
    agent any

    environment {
        DOCKER_REPO = credentials('docker-hub-creds') // Docker Hub credentials ID in Jenkins
        CONTAINER_NAME = 'insta-clone-app'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Rafay-devsinc/insta-clone-1042-main.git'
            }
        }

        stage('Docker Build') {
            steps {
                script {
                    // Use commit hash as tag
                    COMMIT_HASH = sh(returnStdout: true, script: 'git rev-parse --short HEAD').trim()
                    IMAGE_TAG = "${DOCKER_REPO}:${COMMIT_HASH}"

                    sh "docker build -t ${DOCKER_REPO} ."
                    sh "docker tag ${DOCKER_REPO} ${IMAGE_TAG}"
                }
            }
        }

        stage('Docker Login') {
            steps {
                script {
                    sh "echo ${DOCKER_REPO_PSW} | docker login -u ${DOCKER_REPO_USR} --password-stdin"
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    sh "docker push ${IMAGE_TAG}"
                }
            }
        }

        stage('Deploy with Docker Compose') {
            steps {
                script {
                    // Pull image, if exists stop & remove old containers, then deploy
                    sh """
                        if docker pull ${IMAGE_TAG}; then
                            docker compose -f docker-compose.prod.yml down
                        fi
                        docker compose -f docker-compose.prod.yml up -d
                    """
                }
            }
        }
    }
}

