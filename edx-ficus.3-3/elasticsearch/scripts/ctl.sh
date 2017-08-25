#!/bin/sh

JAVA_HOME=/opt/lms_edx/edx-ficus.3-3/java
INSTALL_PATH=/opt/lms_edx/edx-ficus.3-3/elasticsearch
ELASTICSEARCH_PIDFILE=$INSTALL_PATH/tmp/elasticsearch.pid
ELASTICSEARCH="$INSTALL_PATH/bin/elasticsearch -d -p$ELASTICSEARCH_PIDFILE"
ELASTICSEARCH_LOG=$INSTALL_PATH/logs/elasticsearch.log
JAVA_OPTS="-Xmx1g -Xms256m $JAVA_OPTS" # java-memory-settings
ES_JAVA_OPTS=`echo $JAVA_OPTS | sed 's/-Xmx[^ ]*//g' | sed 's/-Xms\([^ ]*\)/-Xms\1 -Xmx\1/g'`
export JAVA_HOME
export ES_MIN_MEM
export ES_MAX_MEM


ELASTICSEARCH_PID=""
ELASTICSEARCH_STATUS=""
PID=""
ERROR=0

ELASTICSEARCH_ASROOT=0
if [ `id|sed -e s/uid=//g -e s/\(.*//g` -eq 0 ]; then
    ELASTICSEARCH_ASROOT=1
fi

get_pid() {
    PID=""
    PIDFILE=$1
    # check for pidfile
    if [ -f "$PIDFILE" ] ; then
        PID=`cat $PIDFILE`
    fi
}

get_elasticsearch_pid() {
    get_pid $ELASTICSEARCH_PIDFILE
    if [ ! $PID ]; then
        return 
    fi
    if [ $PID -gt 0 ]; then
        ELASTICSEARCH_PID=$PID
    fi
}

is_service_running() {
    PID=$1
    if [ "x$PID" != "x" ] && kill -0 $PID 2>/dev/null ; then
        RUNNING=1
    else
        RUNNING=0
    fi
    return $RUNNING
}

is_elasticsearch_running() {
    get_elasticsearch_pid
    is_service_running $ELASTICSEARCH_PID
    RUNNING=$?
    if [ $RUNNING -eq 0 ]; then
        ELASTICSEARCH_STATUS="elasticsearch not running"
    else
        ELASTICSEARCH_STATUS="elasticsearch already running"
    fi
    return $RUNNING
}

start_elasticsearch() {
    is_elasticsearch_running
    RUNNING=$?
    
    if [ $RUNNING -eq 1 ]; then
        echo "$0 $ARG: elasticsearch (pid $ELASTICSEARCH_PID) already running"
    else
	    if [ $ELASTICSEARCH_ASROOT -eq 1 ]; then
	        su elasticsearch -s /bin/sh -c "cd $INSTALL_PATH && $ELASTICSEARCH >/dev/null 2>&1 &"
	    else
            cd $INSTALL_PATH
            nohup $ELASTICSEARCH  >/dev/null 2>&1 &  
	    fi
        sleep 2
        is_elasticsearch_running
        RUNNING=$?
        COUNTER=50
        while [ $RUNNING -eq 0 ] && [ $COUNTER -ne 0 ]; do
            COUNTER=`expr $COUNTER - 1`
            sleep 2
            is_elasticsearch_running
            RUNNING=$?
        done
        LOG_RESULT=""
        LOG_COUNTER=30
        while [ -z "$LOG_RESULT" ] && [ $LOG_COUNTER -ne 0 ]; do
            LOG_COUNTER=`expr $LOG_COUNTER - 1`
            LOG_RESULT=`tail -7 $ELASTICSEARCH_LOG | grep -i "Node" | grep -i "started"`
            sleep 2
        done
        if [ $RUNNING -eq 0 ] || [ $LOG_COUNTER -eq 0 ]; then
            ERROR=1
        fi
        if [ $ERROR -eq 0 ]; then
            echo "$0 $ARG: elasticsearch started"
        else
            echo "$0 $ARG: elasticsearch could not be started"
            ERROR=3
        fi
        cd $INSTALL_PATH
    fi
}

stop_elasticsearch() {
    NO_EXIT_ON_ERROR=$1
    is_elasticsearch_running
    RUNNING=$?

    if [ $RUNNING -eq 0 ]; then
        echo "$0 $ARG: $ELASTICSEARCH_STATUS"
        if [ "x$NO_EXIT_ON_ERROR" != "xno_exit" ]; then
            exit
        else
            return
        fi
    fi
    get_elasticsearch_pid
    kill $ELASTICSEARCH_PID
    sleep 2
    is_elasticsearch_running
    RUNNING=$?
    COUNTER=20
    while [ $RUNNING -ne 0 ] && [ $COUNTER -ne 0 ]; do
        COUNTER=`expr $COUNTER - 1`
        sleep 2
        is_elasticsearch_running
        RUNNING=$?
    done
    if [ $? -eq 0 ]; then
        echo "$0 $ARG: elasticsearch stopped"
    else
        echo "$0 $ARG: elasticsearch could not be stopped"
        ERROR=4
    fi
}

cleanpid() {
    rm -f $ELASTICSEARCH_PIDFILE
}

help() {
    echo "usage: $0 help"
    echo "       $0 (start|stop|restart) elasticsearch

help       - this screen
start      - start the service(s)
stop       - stop  the service(s)
restart    - restart or start the service(s)"
    exit 0
}

if [ "x$1" = "xstart" ]; then
    start_elasticsearch
elif [ "x$1" = "xstop" ]; then
    stop_elasticsearch
elif [ "x$1" = "xstatus" ]; then
    is_elasticsearch_running
    echo "$ELASTICSEARCH_STATUS"
elif [ "x$1" = "xcleanpid" ]; then
    cleanpid
fi

exit $ERROR
