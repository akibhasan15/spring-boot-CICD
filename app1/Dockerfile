FROM tomcat:10.1.19-jdk17-temurin-jammy
WORKDIR /app
COPY . .
RUN apt-get update && apt-get install dos2unix
COPY mvnw pom.xml ./
RUN dos2unix -b ./mvnw
RUN chmod +x ./mvnw
RUN ./mvnw dependency:go-offline
CMD ["./mvnw", "spring-boot:run"]
