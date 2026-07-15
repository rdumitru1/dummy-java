# Stage 1: Build & Test
FROM maven:3.9-eclipse-temurin-17-alpine AS builder
WORKDIR /app
COPY pom.xml .
# Descarcă dependințele în cache (optimizare viteză build)
RUN mvn dependency:go-offline

COPY src ./src
# Compilează, rulează testele unitare și creează binarul .jar
RUN mvn clean package

# Stage 2: Production Runtime Image (Securizată)
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app

# Securitate: Actualizăm pachetele sistemului pentru a aplica patch-urile de securitate (ex: libexpat, p11-kit)
RUN apk update && apk upgrade --no-cache

# Securitate: Creăm un utilizator non-privileged (non-root) pentru execuție
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
USER appuser

# Copiem binarul din etapa anterioară
COPY --from=builder /app/target/demo-0.0.1-SNAPSHOT.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]
