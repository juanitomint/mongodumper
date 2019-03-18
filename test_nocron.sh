#!/bin/bash
if [  -z $1 ]; then 
echo "usage:"
echo "./test.sh your_mongo_container"

else

docker run -it --rm \
 -v $(pwd)/backups:/backups \
 -e MONGO_HOST=mongo \
 -e MONGO_PORT=27017 \
 -e FILE_PREFIX=TEST- \
 -e NO_CRON=true \
 -e QUIET=false \
 -e KEEP_MOST_RECENT_N=2 \
 --link $1:mongo \
 juanitomint/mongodumper
 
fi