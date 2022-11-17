FROM openjdk:8-jdk-alpine

WORKDIR /app
COPY ./target/petclinic.war app.jar

EXPOSE 8282

CMD ["sh", "-c", "java -jar /app/app.jar "]
