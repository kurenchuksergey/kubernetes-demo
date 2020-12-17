ARG APP_HOME=/root/dev/kubernetes-demo/
FROM openjdk:11 AS BUILD_IMAGE
ARG APP_HOME
COPY src/main/java ${APP_HOME}/src/main/java
WORKDIR ${APP_HOME}
COPY build.gradle settings.gradle gradlew gradlew.bat ${APP_HOME}
COPY gradle ${APP_HOME}/gradle
RUN ./gradlew bootJar

FROM openjdk:11-jre
ARG APP_HOME
WORKDIR /root/
COPY --from=BUILD_IMAGE ${APP_HOME}/build/libs/kubernetes-demo.jar .
EXPOSE 8080
CMD ["java","-jar"," kubernetes-demo.jar"]