#!/bin/bash

MAIN_DIR="/srv/docker/redmine"
OUTPUT_DIR="${MAIN_DIR}/backup"
DATE=`date +%Y-%m-%d`
TIME=15

# Export database
DB_FNAME="db_${DATE}"
DB_DIR="${MAIN_DIR}/mysql"
docker exec -it redmine_mysql_1 /var/lib/mysql/backup/backup.sh
sleep $TIME
mv ${DB_DIR}/backup/${DB_FNAME}.sql ${OUTPUT_DIR}/${DB_FNAME}.sql

# Export files
FILES_FNAME="files_${DATE}"
FILES_DIR="${MAIN_DIR}/files"
zip -r ${OUTPUT_DIR}/${FILES_FNAME}.zip ${FILES_DIR}

# Backup
zip -r ${OUTPUT_DIR}/${DATE}.zip ${OUTPUT_DIR}/${DB_FNAME}.sql
rm ${OUTPUT_DIR}/${DATE}.zip ${OUTPUT_DIR}/${DB_FNAME}.sql
