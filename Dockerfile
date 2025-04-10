# Use an official OpenJDK runtime as a parent image
FROM openjdk:11-jre-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the packaged jar from the host machine to the container's /app directory
COPY target/your-application.jar /app/app.jar

# Expose the port the app runs on
EXPOSE 9090

# Command to run the app
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
