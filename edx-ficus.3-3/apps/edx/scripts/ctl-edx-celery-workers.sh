#!/bin/bash

WORKERS=( "edx.lms.core.low" "edx.lms.core.default" "edx.lms.core.high" "edx.lms.core.high_mem" "edx.cms.core.low" "edx.cms.core.default" "edx.cms.core.high" )
WORKERS_CONCURRENCY=( "1" "3" "4" "2" "3" "4" "1" )
start_worker() {
    cd /opt/lms_edx/edx-ficus.3-3/apps/edx/edx-platform
    if [ `id|sed -e s/uid=//g -e s/\(.*//g` -eq 0 ]; then
        su -s /bin/sh daemon -c "/opt/lms_edx/edx-ficus.3-3/apps/edx/bin/python.edxapp ./manage.py lms --settings=aws celery worker -I contentstore.tasks --loglevel=info --queues=$1 --hostname=$1.%h --concurrency=$2 > /opt/lms_edx/edx-ficus.3-3/apps/edx/var/log/$1.log 2>&1 &"
    else
        /opt/lms_edx/edx-ficus.3-3/apps/edx/bin/python.edxapp ./manage.py lms --settings=aws celery worker -I contentstore.tasks --loglevel=info --queues=$1 --hostname=$1.%h --concurrency=$2 > /opt/lms_edx/edx-ficus.3-3/apps/edx/var/log/celery/$1.log 2>&1 &
    fi
    cd - > /dev/null
}

stop_worker() {
    ps axf | grep "/opt/lms_edx/edx-ficus.3-3/apps/edx/venvs/edxapp/bin/.python2.7.bin" | grep "queues=$1" | grep -v grep |  awk '{print "kill -9 " $1}' | sh
}

is_celery_worker_running() {
    if [[ -n $(ps axf | grep "/opt/lms_edx/edx-ficus.3-3/apps/edx/venvs/edxapp/bin/.python2.7.bin" | grep "queues=$1" | grep -v grep) ]]; then
        RUNNING=1
    else
        RUNNING=0
    fi
    return $RUNNING
}

are_edx_workers_running() {
    WORKERS_RUNNING=0
    for WORKER in ${WORKERS[*]}; do
        is_celery_worker_running $WORKER
        let WORKERS_RUNNING=WORKERS_RUNNING+$?
    done
    RES="Number of running workers $WORKERS_RUNNING"
    if [ "$WORKERS_RUNNING" -gt "1" ] && [ "$WORKERS_RUNNING" -lt "7" ]; then
        RUNNING=2
        EDX_STATUS="Some edX Celery workers are running: $RES"
    elif [ "$WORKERS_RUNNING" == "7" ]; then
        RUNNING=1
        EDX_STATUS="edX Celery workers already running"
    else
        RUNNING=0
        EDX_STATUS="edX Celery workers not running"
    fi
    return $RUNNING
}

stop_edx_workers() {
    are_edx_workers_running
    RUNNING=$?
    if [ $RUNNING -eq 0 ]; then
        echo "$0 $ARG: $EDX_STATUS"
        exit
    fi
    for WORKER in ${WORKERS[*]}; do
        stop_worker $WORKER
    done
    are_edx_workers_running
    ERROR=$?
    if [ $ERROR -eq 0 ]; then
        EDX_STATUS="edX workers stopped"
    else
        EDX_STATUS="edX workers could not be stopped: $RES"
        ERROR=3
    fi
}

start_edx_workers() {
    are_edx_workers_running
    RUNNING=$?
    if [ $RUNNING -eq 1 ]; then
        echo "$0 $ARG: edX workers already running"
        exit
    fi

    LIMIT=`expr ${#WORKERS[*]} - 1`
    for INDEX in `seq 0 $LIMIT`; do
        is_celery_worker_running ${WORKERS[$INDEX]}
        if [[ $RUNNING -eq 0 ]]; then
            start_worker ${WORKERS[$INDEX]} ${WORKERS_CONCURRENCY[$INDEX]}
        fi
    done

    sleep 3
    are_edx_workers_running
    RUNNING=$?
    if [ $RUNNING -eq 1 ]; then
        EDX_STATUS="edX workers started"
    else
        EDX_STATUS="edX failed to start: $RES"
    fi
}

status_edx_workers() {
    CONT=0
    STATUS=2
    while [[ $CONT -lt 5 && $STATUS -eq 2 ]]; do
        are_edx_workers_running
        STATUS=$?
        if [[ $STATUS -eq 2 ]]; then
            #some runners are not running, trying to recover them
            start_edx_workers
        fi
        let CONT=CONT+1
        sleep 2
    done
}
if [ "x$1" = "xstart" ]; then
    start_edx_workers
elif [ "x$1" = "xstop" ]; then
    stop_edx_workers
elif [ "x$1" = "xstatus" ]; then
    status_edx_workers
fi
echo "$EDX_STATUS"
