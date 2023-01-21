FROM adoptopenjdk/openjdk11:alpine-jre
WORKDIR /opt/app
EXPOSE 8080
ADD target/springboot-firstapp.jar springboot-firstapp.jar
ENTRYPOINT ["java","-jar","springboot-firstapp.jar"]
