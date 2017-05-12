FROM openjdk:8-jdk-alpine
ADD /target/spring-boot-slf4J-1.5.3.RELEASE.jar spring-boot-slf4J-1.5.3.RELEASE.jar
ENTRYPOINT ["java","-jar","spring-boot-slf4J-1.5.3.RELEASE.jar"]
EXPOSE 8090
