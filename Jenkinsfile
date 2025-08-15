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





pipeline {
    agent any

  

    environment {
        DOCKER_REPO = credentials('docker-hub-creds')
        IMAGE_NAME = 'rafaydevsinc/insta-clone1'
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
                sh "docker build -t $IMAGE_NAME:latest ."
            }
        }

        stage('Docker Login') {
            steps {
                sh "echo $DOCKER_REPO_PSW | docker login -u $DOCKER_REPO_USR --password-stdin"
            }
        }

        stage('Push to Docker Hub') {
            steps {
                sh "docker push $IMAGE_NAME:latest"
            }
        }

        stage('Deploy Latest Container') {
            steps {
                // script {
                    
                    sh """
                        docker stop $CONTAINER_NAME || true
                        docker rm $CONTAINER_NAME || true
                    """

                   
                    sh "docker pull $IMAGE_NAME:latest"

                    
                    sh """
                        docker run -d --name $CONTAINER_NAME -p 3000:3000 $IMAGE_NAME:latest
                    """
                // }
            }
        }
    }
}
