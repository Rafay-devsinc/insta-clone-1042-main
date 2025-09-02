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
        IMAGE_NAME = 'rafaydevsinc/insta-clone1'
        CONTAINER_NAME = 'insta-clone-app'
        // IMAGE_TAG will be set dynamically per commit
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

                         def commitSha = sh(returnStdout: true, script: 'git rev-parse HEAD').trim()

                         githubNotify credentialsId: 'github-token',
                         repo: 'Rafay-devsinc/insta-clone-1042-main',
                         account: 'Rafay-devsinc',
                         sha: commitSha,
                         context: 'Build',
                         status: 'PENDING'
                      
                    // Get short commit hash
                    env.COMMIT_HASH = sh(returnStdout: true, script: 'git rev-parse --short HEAD').trim()
                    env.IMAGE_TAG = "${env.IMAGE_NAME}:${env.COMMIT_HASH}"

                    // Build Docker image
                    sh "docker build -t ${env.IMAGE_NAME} ."
                    sh "docker tag ${env.IMAGE_NAME} ${env.IMAGE_TAG}"
                }
            }
        }

        stage('Docker Login') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-hub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                sh 'docker push $IMAGE_TAG'
            }
        }

        stage('Deploy with Docker Compose') {
            steps {
                script {
                    sh """
                        set -e

                        # Export variables for docker-compose
                        export DOCKER_REPO=${env.IMAGE_NAME}
                        export IMAGE_TAG=${env.COMMIT_HASH}

                        

                        # Deploy new containers
                         docker-compose -f docker-compose.prod.yml up -d --pull always
                    """
                }
            }
        }
    }
}
