#!/bin/bash

TOMCAT=/home/zhizi/fe/softwares/apache-tomcat-8.5.12
option=$1
case "$option" in
    "stop"  ) 
        $TOMCAT/bin/shutdown.sh
        ;;
    *       ) 
        $TOMCAT/bin/shutdown.sh
        echo "staring..."
        sleep 3
        $TOMCAT/bin/startup.sh
        ;;
esac

