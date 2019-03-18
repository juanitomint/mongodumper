FROM alpine:latest
ARG VCS_REF
ARG BUILD_DATE
ENV NO_CRON="false" \
    QUIET="false" \
    MONGO_HOST="mongo"\
    MONGO_PORT="27017"\
    MONGO_USER=""\
    MONGO_PASS=""\
    MONGO_PARALLEL="4"\
    FILE_PREFIX=""
# add Tini (a simple init; ensures that zombie processes are reaped properly)
RUN apk --update add --no-cache tini
ENTRYPOINT ["/sbin/tini", "--"]

RUN apk --update add mongodb-tools

COPY backup.sh /backup.sh
COPY entrypoint.sh /entrypoint.sh

VOLUME /backups

CMD ["/entrypoint.sh"]
