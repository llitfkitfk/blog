pipeline {
  agent any
  stages {
    stage('build') {
      steps {
        sh 'docker build -t llitfkitfk/blog .'
      }
    }
    stage('update blog') {
      steps {
        sh 'docker service update --force blog_blog'
      }
    }
  }
}