import groovy.json.JsonSlurper;
 
node('slave') {
 stage ('Build, Test and Package'){
    env.PATH = "${tool 'M3'}/bin:${env.PATH}"
    git url: "https://github.com/Elhousss/spring-boot-slf4J.git"
    // workaround, taken from https://github.com/jenkinsci/pipeline-examples/blob/master/pipeline-examples/gitcommit/gitcommit.groovy
    def commitid = sh(returnStdout: true, script: 'git rev-parse HEAD').trim()
    def workspacePath = pwd()
    sh "echo ${commitid} > ${workspacePath}/expectedCommitid.txt"
    sh "mvn clean install -DskipTests -Dcommitid=${commitid}"
 }
}
 
/*node('slave') {
    stage 'Stop, Deploy and Start'
    // shutdown
    sh 'curl -X POST http://localhost:8090/shutdown || true'
    // copy file to target location
    sh 'cp target/*.jar /tmp/'
    // start the application
    sh 'nohup java -jar /tmp/*.jar &'
    // wait for application to respond
    // sh 'while ! httping -qc1 http://localhost:8090 ; do sleep 1 ; done'
}*/
 
node('slave') {
    def app 
 stage ('Build image'){
    /* This builds the actual image; synonymous to
     * docker build on the command line */
     sh 'sudo chmod 777 /var/run/docker.sock'
     app = docker.build("elhousss/spring-boot-slf4j")
 }
 
 stage ('Push image'){
     /* we'll push the image with two tags:
     * First, the incremental build number from Jenkins
     * Second, the 'latest' tag. */
     // https://hub.docker.com/r/elhousss/spring-boot-slf4j

     withDockerRegistry([credentialsId: 'elhousss', url: 'https://index.docker.io/v1/']) {
        app.push("${env.BUILD_NUMBER}")
        app.push("latest")
     }
 }
 stage ('Run Application') {
      // Run application using Docker image
      sh "docker run -d -p 8090:8090 -v /tmp:/tmp --name image-app elhousss/spring-boot-slf4j"
 }
}
/*node{
    stage 'Smoketest'
    def workspacePath = pwd()
    sh "curl --retry-delay 10 --retry 5 http://localhost:8090/info -o ${workspacePath}/info.json"
    if (deploymentOk()){
        return 0
    } else {
        return 1
    }
}
 
  def deploymentOk(){
    def workspacePath = pwd()
    expectedCommitid = new File("${workspacePath}/expectedCommitid.txt").text.trim()
    actualCommitid = readCommitidFromJson()
    println "expected commitid from txt: ${expectedCommitid}"
    println "actual commitid from json: ${actualCommitid}"
    return expectedCommitid == actualCommitid
}
 
def readCommitidFromJson() {
    def workspacePath = pwd()
    def slurper = new JsonSlurper()
    def json = slurper.parseText(new File("${workspacePath}/info.json").text)
    def commitid = json.app.commitid
    return commitid
}*/
