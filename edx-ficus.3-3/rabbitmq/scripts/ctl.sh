#!/bin/sh
. /opt/lms_edx/edx-ficus.3-3/scripts/setenv.sh

ERROR=0

RABBITMQ_START="/opt/lms_edx/edx-ficus.3-3/rabbitmq/sbin/rabbitmq-server -detached"
RABBITMQ_STOP="/opt/lms_edx/edx-ficus.3-3/rabbitmq/sbin/rabbitmqctl stop"
RABBITMQ_STOP_APP="/opt/lms_edx/edx-ficus.3-3/rabbitmq/sbin/rabbitmqctl stop_app"
RABBITMQ_STATUS="/opt/lms_edx/edx-ficus.3-3/rabbitmq/sbin/rabbitmqctl status"
PID=""

get_epmd_pid() {
    PID=`COLUMNS=650 ps aux | grep -P "/opt/lms_edx/edx-ficus.3-3/erlang/lib/erlang/erts-([0-9].+[0-9])/bin/epmd" | grep -v grep | awk '{print $2}'`
    if [ ! "$PID" ]; then
        return
    fi
}

is_service_running() {
    RUN=`ps aux | grep /opt/lms_edx/edx-ficus.3-3/rabbitmq/rabbitmq_home | grep -v grep | awk '{print $2}'`
    if [ "$RUN" = "" ]; then
        RUNNING=0
    else
        RUNNING=1
    fi
    return $RUNNING
}

status() {
    is_service_running
    RUNNING=$?
    if [ $RUNNING -eq 1 ]; then
        echo "RabbitMQ already running"
    else
        echo "RabbitMQ is not running"
    fi
    return $RUNNING
}

start() {
    is_service_running
    RUNNING=$?
    if [ $RUNNING -eq 0 ]; then
	    if [ `id|sed -e s/uid=//g -e s/\(.*//g` -eq 0 ]; then
	        su - rabbitmq -s /bin/sh -c "$RABBITMQ_START" > /dev/null
	    else
	        $RABBITMQ_START > /dev/null
	    fi
        COUNTER=40
        while [ $RUNNING -eq 0 ] && [ $COUNTER -ne 0 ]; do
            COUNTER=`expr $COUNTER - 1`
            sleep 1
            is_service_running
            RUNNING=$?
        done
        is_service_running
        RUNNING=$?
        if [ $RUNNING -eq 1 ]; then
            echo "$0 $ARG: RabbitMQ started"
            ERROR=0
        else
            echo "$0 $ARG: RabbitMQ could not be started"
            ERROR=1
        fi
    else
        echo "RabbitMQ already running"
    fi
}

stop() {
    is_service_running
    RUNNING=$?
    if [ $RUNNING -eq 1 ]; then
        if $RABBITMQ_STOP; then
	        ERROR=0
            sleep 5
            get_epmd_pid
            kill -9 $PID
            echo "RabbitMQ stopped"
        else
	        echo "Failed"
	        ERROR=1
        fi
    else
        echo "RabbitMQ already stopped"
    fi
}

restart() {
       stop
       start
}

case "$1" in
 start)
       start
       ;;
 stop)
       stop
       ;;
 restart|reload)
       restart
       ;;
 status)
       status;;
 *)
       echo $"Usage: $0 {start|stop|restart|status}"
       exit 1
esac

exit 0
