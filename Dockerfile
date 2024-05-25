# Use slim image for smaller size
FROM openjdk:17-jdk-slim

# Set environment variable for Java version (optional)
ENV JAVA_VERSION=17

# Copy everything from current directory
COPY target/docker-k8s-jenkins-demo-0.0.1-SNAPSHOT.jar docker-k8s-jenkins-demo-0.0.1-SNAPSHOT.jar

# Expose container port (if your app listens on a specific port)
EXPOSE 9090

# Run your Spring Boot application (replace with your command)
CMD ["java", "-jar", "docker-k8s-jenkins-demo-0.0.1-SNAPSHOT.jar"]