
FROM openjdk:11-jre-slim

WORKDIR /app

COPY target/your-application.jar /app/app.jar

# Expose the port the app runs on
EXPOSE 9090

ENTRYPOINT ["java", "-jar", "/app/app.jar"]
