#!/bin/bash
XQUEUE_CONSUMER_START="/opt/lms_edx/edx-ficus.3-3/apps/xqueue/bin/django-admin.xqueue run_consumer >/dev/null 2>&1 &"
XQUEUE_CONSUMER_STATUS=""
ERROR=0
is_xqueue_consumer_running() {
    if [[ -n $(ps axf | grep "/opt/lms_edx/edx-ficus.3-3/apps/xqueue/venvs/xqueue/bin/.python2.7.bin" | grep -v grep) ]]; then
        RUNNING=1
        XQUEUE_CONSUMER_STATUS="already running"
    else
        RUNNING=0
        XQUEUE_CONSUMER_STATUS="not running"
    fi
    return $RUNNING
}
stop_xqueue_consumer() {
    is_xqueue_consumer_running
    if [ $RUNNING -eq 0 ]; then
        return
    fi
    ps axf | grep "/opt/lms_edx/edx-ficus.3-3/apps/xqueue/venvs/xqueue/bin/.python2.7.bin" | grep -v grep |  awk '{print "kill -9 " $1}' | sh
    is_xqueue_consumer_running
    RUNNING=$?
    if [ $RUNNING -eq 1 ]; then
        XQUEUE_CONSUMER_STATUS="could not be stopped"
        ERROR=3
    else
        XQUEUE_CONSUMER_STATUS="stopped"
    fi
}
start_xqueue_consumer() {
    is_xqueue_consumer_running
    RUNNING=$?
    if [ $RUNNING -eq 1 ]; then
        return
    fi
    if [ `id|sed -e s/uid=//g -e s/\(.*//g` -eq 0 ]; then
        su -s /bin/sh daemon -c "eval $XQUEUE_CONSUMER_START"
    else
        eval $XQUEUE_CONSUMER_START
    fi
    sleep 1
    is_xqueue_consumer_running
    RUNNING=$?
    if [ $RUNNING -eq 1 ]; then
        XQUEUE_CONSUMER_STATUS="started"
    else
        XQUEUE_CONSUMER_STATUS="failed to start"
    fi
}
status_xqueue_consumer() {
    is_xqueue_consumer_running
}
if [ "x$1" = "xstart" ]; then
    start_xqueue_consumer
elif [ "x$1" = "xstop" ]; then
    stop_xqueue_consumer
elif [ "x$1" = "xstatus" ]; then
    status_xqueue_consumer
fi
echo "XQueue consumer $XQUEUE_CONSUMER_STATUS"
exit $ERROR

