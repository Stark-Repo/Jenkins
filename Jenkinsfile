pipeline{
  agent { 
    label 'docker'
  }
  tools{
    Maven 'maven3'
    jdk 'java17'
  }
  environments {
        App_name = "My_App"
        RELEASE = "1.0.0"
        Docker_User = "starkdocker475"
        Docker_Pass = "docker_hub credentials"
        Image_name = "${Docker_User}"+"/"+"${App_name}
        Image_tag = "${RELEASE}-${Build_number}"
    }
  stages{
    stage("clean workspace") {
      steps{
        CleanWS()
      }
    }
    stage("Git Checkout") {
      steps{
        git branch: 'main', credentialsId: 'git-token', url: 'https://github.com/Stark-Repo/Jenkins.git'
      }
    }
    stage("build with maven") {
      steps{
          sh 'mvn clean package'
      }
    }
    stage("Test with maven") {
      steps{
          sh 'mvn test'
      }
    }
    stage("Build the image with docker") {
      steps{
        script{
        withDockerRegistry('${Docker_user}','${Docker_Pass}' ) {
            docker_image = docker.build "${Image_name}"
        }
          withDockerRegistry('${Docker_user}','${Docker_Pass}' ) {
                        docker_image.push("${IMAGE_TAG}")
                        docker_image.push('latest')
       }
     }
    }
  }
}
}
