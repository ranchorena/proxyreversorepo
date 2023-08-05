pipeline {
    agent any
  
    stages {
        stage('Transfer files to remote server') {
            steps {
                sshagent(['SSH_Server_135_geouser']) {
                    sh 'scp C:/Code/Proxy_Reverso/Dockerfile geouser@192.168.1.135:/usr/src/app/proxyreverso/'
                    sh 'scp C:/Code/Proxy_Reverso/nginx.conf geouser@192.168.1.135:/usr/src/app/proxyreverso/'
                }
            }
        }        
        stage('Build Docker image') {
            steps {
                sshagent(['SSH_Server_135_geouser']) {
                    sh '''
                        ssh geouser@192.168.1.135 "
                            cd /usr/src/app/proxyreverso && 
                            if docker ps -a | grep proxy-reverso-nginx >/dev/null 2>&1; then docker stop proxy-reverso-nginx && 
                            docker rm proxy-reverso-nginx; fi && 
                            docker image rm -f proxy-reverso-nginx:latest || true && 
                            docker build -t proxy-reverso-nginx:latest --no-cache /usr/src/app/proxyreverso
                        "
                    '''             
                }
            }
        }      
        stage('Run Docker container') {
            steps {
                sshagent(['SSH_Server_135_geouser']) {
                    sh '''
                        ssh geouser@192.168.1.135 "
                            docker run -d --restart=always -p 80:80 --name proxy-reverso-nginx proxy-reverso-nginx:latest
                        "
                    '''
                }
            }
        } 
    } 
    post {
        success {
            emailext body: "La subida de proxy-reverso-nginx se ha completado con exito.\n\n" +
                           "Ultimo mensaje de commit: ${env.LAST_COMMIT_MESSAGE}\n\n" +
                           "Commit Id: ${env.LAST_COMMIT_HASH}.\n\n" +
                           "proxy-reverso-nginx\n" +
                           "http://192.168.1.135:80\n\n" +
                           "Job Name: ${env.JOB_NAME}\n" +
                           "Build: ${env.BUILD_NUMBER}\n" +
                           "Console output: ${env.BUILD_URL}",  
                     subject: 'proxy-reverso-nginx - Subida Exitosa',
                     to: 'Raul.Anchorena@geosystems.com.ar'
        }
        failure {
            emailext body: "La subida de proxy-reverso-nginx ha fallado.\n\n" +
                           "Job Name: ${env.JOB_NAME}\n" +
                           "Build: ${env.BUILD_NUMBER}\n" +
                           "Console output: ${env.BUILD_URL}", 
                     subject: 'proxy-reverso-nginx - La subida ha Fallado - ERROR',
                     to: 'Raul.Anchorena@geosystems.com.ar'
        }
    }
}

