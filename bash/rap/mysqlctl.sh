#!/bin/bash
# for mysql-5.7.17

MYSQL=/home/zhizi/fe/softwares/mysql-5.7.17-linux-glibc2.5-x86_64
option=$1

function stop_server {
    pid=`ps aux | grep -P '\-\-port=4567' | grep -v grep | awk '{print $2}'`
    if [[ "$pid" -ne "" ]]; then
        kill $pid
    fi
}

# $MYSQL/bin/mysqld \
# 	--initialize \
# 	--basedir=$MYSQL \
# 	--log-error=$MYSQL/logs/mysqld.log \
# 	--datadir=$MYSQL/data 

# deprecated
# $MYSQL/bin/mysql_install_db \
#     --basedir=$MYSQL \
#     --datadir=$MYSQL/data 

function start_server {
    $MYSQL/bin/mysqld \
        --basedir=$MYSQL \
        --datadir=$MYSQL/data \
        --port=4567 \
        --plugin-dir=$MYSQL/lib/plugin \
        --user=root \
        --log-error=$MYSQL/logs/mysqld.log \
        --pid-file=$MYSQL/pids/mysqld.pid \
        --socket=$MYSQL/mysql.sock &
}

case "$option" in
    "stop"  ) 
    stop_server
    ;;

    *       ) 
    stop_server
    echo "staring..."
    sleep 3
    start_server
    ;;
esac
