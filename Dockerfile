#FROM java:8-jdk-alpine

#COPY ./target/demo-docker-0.0.1-SNAPSHOT.jar /usr/app/

#WORKDIR /usr/app

#RUN sh -c 'touch demo-docker-0.0.1-SNAPSHOT.jar'

#ENTRYPOINT ["java","-jar","demo-docker-0.0.1-SNAPSHOT.jar"]

FROM tomcat:latest
RUN cp -R  /usr/local/tomcat/webapps.dist/*  /usr/local/tomcat/webapps
COPY /webapp/target/*.war /usr/local/tomcat/webapps
