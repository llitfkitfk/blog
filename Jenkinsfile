pipeline {
  agent any
  stages {
    stage('pull blog') {
      steps {
        sh 'docker pull llitfkitfk/blog'
      }
    }
    stage('update blog') {
      steps {
        sh 'docker service update --force blog_blog'
      }
    }
  }
}