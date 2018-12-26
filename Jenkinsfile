pipeline {
  agent any
  stages {
    stage('build image') {
      steps {
        sh 'docker build -t llitfkitfk/blog .'
      }
    }
    stage('push image') {
      steps {
        sh '''echo $DOCKER_USER_PASSWORD | docker login --password-stdin -u $DOCKER_USER_NAME

docker push llitfkitfk/blog

docker logout'''
      }
    }
    stage('update service') {
      steps {
        sh 'docker service update --image llitfkitfk/blog:latest blog_blog'
      }
    }
  }
}