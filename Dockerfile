FROM openjdk:19
WORKDIR /opt/app
EXPOSE 8080
ADD target/springboot-firstapp.jar springboot-firstapp.jar
ENTRYPOINT ["java","-jar","/springboot-firstapp.jar"]
