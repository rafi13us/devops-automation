FROM openjdk:19
EXPOSE 8080
ADD target/springboot-firstapp.jar springboot-firstapp.jar
ENTRYPOINT ["java","-jar","/springboot-firstapp.jar"]