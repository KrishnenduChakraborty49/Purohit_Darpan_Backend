# Stage 1: Build with Maven (heavy image, not deployed)
FROM maven:3.9.7-eclipse-temurin-21 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Stage 2: Run with slim JRE only (~200MB vs 1.5GB)
FROM eclipse-temurin:21-jre-alpine
WORKDIR /app
COPY --from=build /app/target/purohit-darpan-1.0.0.jar app.jar

EXPOSE 10000

CMD ["sh", "-c", "java -Xmx300m -XX:+UseSerialGC -Dserver.address=0.0.0.0 -jar app.jar"]