FROM openjdk:17
COPY ./java/src/main/java/app/ /app
WORKDIR /app
ENTRYPOINT ["java","Main"]