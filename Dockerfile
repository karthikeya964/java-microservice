
FROM openjdk:11-jre-slim

WORKDIR /app

COPY target/java-microservice-1.0-SNAPSHOT.jar /app/app.jar

# Expose the port the app runs on
EXPOSE 9090

ENTRYPOINT ["java", "-jar", "/app/app.jar"]
