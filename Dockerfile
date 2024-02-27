FROM eclipse-temurin:17-jdk-focal
WORKDIR /app
#COPY . .
RUN apt-get update && apt-get install dos2unix
COPY mvnw pom.xml ./
RUN dos2unix -b ./mvnw
RUN ./mvnw dependency:go-offline
#COPY src ./src
CMD ["./mvnw", "spring-boot:run"]