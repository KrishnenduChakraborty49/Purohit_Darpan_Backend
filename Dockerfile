FROM maven:3.9.7-eclipse-temurin-21
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests
EXPOSE 8080
# Use a specific filename. If this fails, the build fails (good for debugging).
CMD ["sh", "-c", "java -Xmx384m -Dserver.port=${PORT} -Dserver.address=0.0.0.0 -jar target/purohit-darpan-1.0.0.jar"]