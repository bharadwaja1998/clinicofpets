FROM tomcat:9.0.69-jdk8-corretto-al2

COPY ./target/petclinic.war /usr/local/tomcat/webapps/app.war

EXPOSE 8080

CMD ["catalina.sh", "run"]
