FROM openjdk:8 as BUILD_IMAGE

WORKDIR /
COPY . .
RUN chmod +x ./mvnw
RUN ./mvnw -DskipTests package

FROM openjdk:8

COPY --from=BUILD_IMAGE /target/postgres-demo-0.0.1-SNAPSHOT.jar /app.jar
EXPOSE 8080/tcp
ENTRYPOINT ["java", "-jar", "/app.jar"]