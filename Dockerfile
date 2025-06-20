# Use a lightweight OpenJDK 24 base image
FROM maven:3.9.10-openjdk:24-jdk-slim AS build

# Set the active profile for the Spring Boot application
ENV SPRING_PROFILES_ACTIVE=prod

# Set environment variables for the application
ENV DATABASE_URL=sql3.freesqldatabase.com
ENV DATABASE_NAME=sql3785811
ENV DATABASE_USER=sql3785811
ENV DATABASE_PASSWORD=sGQj8rrNWj
# Set the working directory inside the container
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline
# Copy the Maven project files into the container
COPY src ./src
RUN mvn package -DskipTests

# Copy the Spring Boot JAR file into the container
FROM openjdk:24-jdk-slim AS production
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar

# Expose the port your Spring Boot application listens on (default is 8080)
EXPOSE 8080

# Define the command to run the Spring Boot application
ENTRYPOINT ["java", "-jar", "app.jar"]