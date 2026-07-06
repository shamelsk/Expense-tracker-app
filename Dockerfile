# Stage 1 - Build the JAR using maven
FROM maven:3.9-eclipse-temurin-17 AS builder

WORKDIR /app

COPY . .

# Create JAR file
RUN mvn clean package -DskipTests=true

# Stage 2 - execute JAR file from above stage
FROM eclipse-temurin:21-jre-alpine

WORKDIR /app

COPY --from=builder /app/target/*.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]
