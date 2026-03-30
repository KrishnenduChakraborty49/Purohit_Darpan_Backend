FROM maven:3.9.7-eclipse-temurin-21
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests
EXPOSE 10000
CMD ["sh", "-c", "java -Xmx384m -Dserver.port=${PORT:10000} -Dserver.address=0.0.0.0 -jar target/purohit-darpan-*.jar"]