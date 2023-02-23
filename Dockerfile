FROM maven:3.8.3-openjdk-17 as build
WORKDIR /tmp/dockerproject
COPY . .
RUN mvn package 

FROM eclipse-temurin:17-jdk
WORKDIR /tmp/dockerproject
COPY --from=build /tmp/dockerproject/target/*.jar app.jar
RUN apt update && apt install -y curl
EXPOSE 8080
ENTRYPOINT ["java","-jar","app.jar"]
HEALTHCHECK --interval=60s --timeout=10s --start-period=20s --retries=3 CMD curl -f localhost/
#DevOps(Jenkins,Docker,K8s), Design Patterns, Java Concurrency