FROM maven:3.9.7-eclipse-temurin-21 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

FROM eclipse-temurin:21-jre-alpine
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["sh", "-c", "java -Xmx384m -Dserver.port=${PORT} -Dserver.address=0.0.0.0 -jar app.jar --server.port=${PORT} --server.address=0.0.0.0"]