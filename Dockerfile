# Use Maven to build the application
FROM maven:3.9-eclipse-temurin-17 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Use a lightweight JRE image for runtime
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar

# Expose port 8080 (Cloud Run default)
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]

