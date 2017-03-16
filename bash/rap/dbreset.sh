#!/bin/bash
# for mysql-5.7.17

MYSQL=/home/irice/fe/softwares/mysql-5.7.17-linux-glibc2.5-x86_64
RAPSQL=/home/irice/fe/softwares/ROOT/WEB-INF/classes/database/initialize.sql

option=$1

function stop_server {
    pid=`ps aux | grep -P '\-\-port=4567' | grep -v grep | awk '{print $2}'`
    if [[ "$pid" -ne "" ]]; then
        kill $pid
    fi
}

function db_initialize {
    $MYSQL/bin/mysqld \
        --initialize-insecure \
        --basedir=$MYSQL \
        --log-error=$MYSQL/logs/mysqld.log \
        --datadir=$MYSQL/data 
}

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

function create_db {
    $MYSQL/bin/mysql \
        --port=4567 \
        --user=root -p \
        --socket=$MYSQL/mysql.sock <<EndOfSQL 
        alter user 'root'@'localhost' identified by 'sophon-fe';
        show databases;
        create database rap_db default charset utf8 collate utf8_general_ci;
        grant all on rap_db.* to 'rap'@'localhost' identified by 'sophon';
        flush privileges;
EndOfSQL

    $MYSQL/bin/mysql \
        --port=4567 \
        --user=root -p \
        --socket=$MYSQL/mysql.sock < $RAPSQL 
}

stop_server
echo "stop server..."
sleep 3
rm -rf $MYSQL/data/*
db_initialize
echo "start server..."
sleep 2
start_server
echo "create db..."
sleep 3
create_db


