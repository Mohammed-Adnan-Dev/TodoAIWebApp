FROM maven:3.8.5-openjdk-17 AS build
WORKDIR /app
COPY . .
# Add this line to verify the pom.xml is correct
RUN cat pom.xml
RUN mvn clean package -DskipTests

FROM tomcat:9.0-jdk17
COPY --from=build /app/target/TodoAIWebApp.war /usr/local/tomcat/webapps/
EXPOSE 8080
CMD ["catalina.sh", "run"]
