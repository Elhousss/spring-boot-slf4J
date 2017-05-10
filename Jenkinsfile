node {
   def mvnHome
   stage('Preparation') { // for display purposes
      // Get the Maven tool.
      git "https://github.com/Elhousss/spring-boot-slf4J.git"
      // ** NOTE: This 'M3' Maven tool must be configured
      // **       in the global configuration.  
      mvnHome = tool 'M3'
   }
   stage('Build') {
      // Run the maven build
      sh "'${mvnHome}/bin/mvn' clean package"
   }
   stage('Dockerize') {
      sh "sudo docker build -t app-spring-boot-slf4J"
   }
   stage('Run') {
      sh "docker run --name app -p 8080:8080 -d app-spring-boot-slf4J"
   }
}
