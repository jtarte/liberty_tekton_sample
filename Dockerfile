# Start with OL runtime.
FROM openliberty/open-liberty:full-java11-openj9-ubi

COPY --chown=1001:0 src/main/liberty/config/server.xml /config/
COPY --chown=1001:0 data/examples/*.war /config/apps/
#RUN chown 1001 /config/apps
USER 1001