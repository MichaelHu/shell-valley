#!/bin/bash
# for mysql-5.7.17

MYSQL=/home/zhizi/fe/softwares/mysql-5.7.17-linux-glibc2.5-x86_64
BACKUP=/home/zhizi/fe/dbbackup

function backup {
    dumpfile=$BACKUP/`date +%Y%m%d-%H%M%S`.sql
    $MYSQL/bin/mysqldump \
        --port=4567 \
        --user=root \
        --socket=$MYSQL/mysql.sock \
        -p rap_db > $dumpfile 
}

backup
