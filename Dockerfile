# Use a lightweight OpenJDK 24 base image
FROM maven:3.9.9-eclipse-temurin-24 AS build
# Set the active profile for the Spring Boot application
ENV SPRING_PROFILES_ACTIVE=prod

# Set the working directory inside the container
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline
# Copy the Maven project files into the container
COPY src ./src
RUN mvn package -DskipTests

# Copy the Spring Boot JAR file into the container
FROM eclipse-temurin:24-jre AS runtime
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar

# Expose the port your Spring Boot application listens on (default is 8080)
EXPOSE 8080

# Define the command to run the Spring Boot application
ENTRYPOINT ["java", "-jar", "app.jar"]