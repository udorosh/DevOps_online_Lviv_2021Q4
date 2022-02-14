FROM openjdk:8-jre-alpine
RUN mkdir /app && addgroup -S kiykomi && adduser -S -s /bin/false -G kiykomi kiykomi
WORKDIR /app
COPY ./docker/toolbox /app
RUN chown -R kiykomi:kiykomi /app
USER kiykomi
EXPOSE 8080
CMD ["java", "-jar", "app.jar"]
