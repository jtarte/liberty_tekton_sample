# Start with OL runtime.
FROM docker.io/maven:3.6.0-jdk-8-slim AS build-stage
COPY . /project
WORKDIR /project
RUN mvn clean package


FROM docker.io/openliberty/open-liberty:full-java11-openj9-ubi

RUN ls -aR / | grep war

COPY --chown=1001:0 ./src/main/liberty/config/server.xml /config/
COPY --chown=1001:0 --from=build-stage /project/data/examples/*.war /config/apps/
#RUN chown 1001 /config/apps
USER 1001