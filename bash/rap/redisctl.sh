#!/bin/bash

REDIS=/home/zhizi/fe/softwares/redis-3.2.8

option=$1

function stop_server {
    pid=`ps aux | grep -P 'redis-server.*7379' | grep -v grep | awk '{print $2}'`
    if [[ "$pid" -ne "" ]]; then
        kill $pid
    fi
}

case "$option" in
    "stop"  ) 
    stop_server
    ;;

    *       ) 
    stop_server
    echo "staring..."
    sleep 3
    nohup $REDIS/src/redis-server --port 7379 &
    ;;
esac

