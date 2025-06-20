# Use a lightweight OpenJDK 24 base image
FROM openjdk:24-jdk-slim

# Set the active profile for the Spring Boot application
ENV SPRING_PROFILES_ACTIVE=prod

# Set environment variables for the application
ENV DATABASE_URL=sql3.freesqldatabase.com
ENV DATABASE_NAME=sql3785811
ENV DATABASE_USER=sql3785811
ENV DATABASE_PASSWORD=sGQj8rrNWj
# Set the working directory inside the container
WORKDIR /app

# Copy the Spring Boot JAR file into the container

COPY target/*.jar /app/app.jar

# Expose the port your Spring Boot application listens on (default is 8080)
EXPOSE 8080

# Define the command to run the Spring Boot application
ENTRYPOINT ["java", "-jar", "app.jar"]