FROM openjdk:8-jdk-alpine

COPY ./target/petclinic.war app.jar

EXPOSE 8282

ENTRYPOINT ["sh", "-c", "java -jar /app.jar "]
