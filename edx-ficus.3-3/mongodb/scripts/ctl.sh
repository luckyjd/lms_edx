#! /bin/sh

MONGODB_PIDFILE=/opt/lms_edx/edx-ficus.3-3/mongodb/tmp/mongodb.pid
MONGODB_LOCKFILE=/opt/lms_edx/edx-ficus.3-3/mongodb/data/db/mongod.lock
MONGODB_CONFIG_FILE=/opt/lms_edx/edx-ficus.3-3/mongodb/mongodb.conf
MONGODB_SERVER=/opt/lms_edx/edx-ficus.3-3/mongodb/bin/mongod
MONGODB_LOGFILE=/opt/lms_edx/edx-ficus.3-3/mongodb/log/mongodb.log
MONGODB_PORT=27017
MONGODB_STATUS=""
MONGODB_PID=""
MONGODB_START="$MONGODB_SERVER --config $MONGODB_CONFIG_FILE --pidfilepath $MONGODB_PIDFILE"

LC_ALL="C"
export LC_ALL

ERROR=0


get_pid() {
    PID=""
    PIDFILE=$1
    # check for pidfile
    if [ -f "$PIDFILE" ] ; then
        PID=`cat $PIDFILE`
    fi
}

get_mongodb_pid() {
    get_pid $MONGODB_PIDFILE
    if [ ! "$PID" ]; then
        return
    fi
    if [ "$PID" -gt 0 ]; then
        MONGODB_PID=$PID
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

is_mongodb_running() {
    get_mongodb_pid
    is_service_running $MONGODB_PID
    RUNNING=$?
    if [ $RUNNING -eq 0 ]; then
        MONGODB_STATUS="mongodb not running"
    else
        MONGODB_STATUS="mongodb already running"
    fi
    return $RUNNING
}

start_mongodb() {
    is_mongodb_running
    RUNNING=$?

    if [ $RUNNING -eq 1 ]; then
        echo "$0 $ARG: mongodb (pid $MONGODB_PID) already running"
    else
	if [ `id|sed -e s/uid=//g -e s/\(.*//g` -eq 0 ]; then
	    su mongodb -s /bin/sh -c "$MONGODB_START >> $MONGODB_LOGFILE 2>&1"
	else
	    $MONGODB_START >> $MONGODB_LOGFILE 2>&1
	fi
	sleep 3
	is_mongodb_running
	RUNNING=$?
	if [ $RUNNING -eq 0 ]; then
	    ERROR=1
	fi

        if [ $ERROR -eq 0 ]; then
            echo "$0 $ARG: mongodb started at port 27017"
	    sleep 2
        else
            echo "$0 $ARG: mongodb could not be started"
            ERROR=3
        fi
    fi
}

stop_mongodb() {
    NO_EXIT_ON_ERROR=$1
    is_mongodb_running
    RUNNING=$?

    if [ $RUNNING -eq 0 ]; then
        echo "$0 $ARG: $MONGODB_STATUS"
        if [ "x$NO_EXIT_ON_ERROR" != "xno_exit" ]; then
            exit
        else
            return
        fi
    fi

    get_mongodb_pid
    MONGODB_STOP="kill $MONGODB_PID"
    if [ `id|sed -e s/uid=//g -e s/\(.*//g` -eq 0 ]; then
        su mongodb  -c "$MONGODB_STOP  >> $MONGODB_LOGFILE 2>&1"
    else
        $MONGODB_STOP  >> $MONGODB_LOGFILE 2>&1
    fi
    sleep 2
    
    is_mongodb_running
    RUNNING=$?

    if [ $RUNNING -eq 0 ]; then
	echo "$0 $ARG: mongodb stopped"
    else
        echo "$0 $ARG: mongodb could not be stopped"
        ERROR=4
    fi
}


cleanpid() {
    rm -f $MONGODB_PIDFILE $MONGODB_LOCKFILE
}

if [ "x$1" = "xstart" ]; then
	start_mongodb
    sleep 5

elif [ "x$1" = "xstop" ]; then
    stop_mongodb
	sleep 2
elif [ "x$1" = "xstatus" ]; then
    is_mongodb_running
    echo "$MONGODB_STATUS"
elif [ "x$1" = "xcleanpid" ]; then
    cleanpid
fi

exit $ERROR

