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
            //archiveArtifacts '**/target/*.jar'
         
      }
      echo "befor deploye"
      satge('Deploy') {
         echo "in deploy"
          // copy file to target location
          sh 'cp target/*.jar /tmp/'
          // start the application
          sh 'nohup java -jar /tmp/*.jar &'
          // wait for application to respond
          sh 'while ! httping -qc1 http://localhost:8088 ; do sleep 1 ; done'
         echo "last in deploy"
      }
      echo "after deploy"      
        
      //stage('Dockerize') {
      //   sh "docker build -t app-spring-boot-slf4J"
      //}
      //stage('Run') {
      //   sh "docker run --name app -p 8080:8080 -d app-spring-boot-slf4J"
      //}
   }
