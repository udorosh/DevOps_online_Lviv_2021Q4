FROM openjdk:8-jre-alpine
RUN mkdir /app && addgroup -S udorosh && adduser -S -s /bin/false -G udorosh udorosh
WORKDIR /app
COPY ./docker/toolbox /app
RUN chown -R udorosh:udorosh /app
USER udorosh
EXPOSE 8080
CMD ["java", "-jar", "app.jar"]
