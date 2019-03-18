#!/bin/sh

set -e
cd /backups
if [ "$QUIET" == "true" ] ; then
    add_quiet=" --quiet "

fi

FILENAME="$FILE_PREFIX$(date -u +%FT%TZ).archive.gz"
$silent
# make a new backup
time mongodump \
-h ${MONGO_HOST:-mongo} \
-p ${MONGO_PORT:-27017} \
--authenticationDatabase ${AUTHDB:-admin} \
--username=${MONGO_USER:-} \
--password=${MONGO_PASS:-} \
--numParallelCollections ${MONGO_PARALLEL:-4}
$add_quiet \
--archive --gzip > "$FILENAME"

SIZE="$(ls -lh "$FILENAME" | awk '{print $5}')"

# clean up old backups
ls -t | tail -n +$((${KEEP_MOST_RECENT_N:-14} + 1)) | xargs -r rm --

echo "successfully created backup: $FILENAME, size: $SIZE"
