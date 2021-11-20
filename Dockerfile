# Start by creating the war archive
# use maven image
FROM docker.io/maven:3.6.0-jdk-8-slim AS build-stage

COPY . /project
WORKDIR /project
#build the war archive
RUN mvn clean package

# Create the final image
# use liberty image
FROM docker.io/openliberty/open-liberty:full-java11-openj9-ubi

COPY --chown=1001:0 ./src/main/liberty/config/server.xml /config/
COPY --chown=1001:0 --from=build-stage /project/target/war/*.war /config/apps/
USER 1001