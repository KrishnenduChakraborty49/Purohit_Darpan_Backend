FROM maven:3.9.7-eclipse-temurin-21 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

FROM eclipse-temurin:21-jre-alpine
WORKDIR /app
# Explicitly copy only the fat JAR (usually the largest one)
COPY --from=build /app/target/purohit-darpan-1.0.0.jar app.jar
EXPOSE 8080
# Use a simple entrypoint to minimize shell issues
ENTRYPOINT ["java", "-Xmx384m", "-Dserver.port=${PORT}", "-Dserver.address=0.0.0.0", "-jar", "app.jar"]