#!/bin/sh
#
#chkconfig: 2345 99 05
# ---------------------------------------------------------------------------
# AppDynamics Controller bootup script
#
# ---------------------------------------------------------------------------
# Description: Start up the AppDynamics Controller at bootup and manage through /etc/init.d
#
# Scripts in /etc/init.d are owned by root and must be executed by root. 
# When the AppDynamics init.d script executes, it uses /bin/su to execute the controller instance as another user, appdynamics by default.
# This user account must exist and have permission to read and write all files in the CONTROLLER_HOME directory.
#
# Installation:
# 1. Modify "APPD_RUNTIME_USER" to match your environment
#
# 2. su - root
#
# 3. ln -s CONTROLLER_HOME/init.d.sh /etc/init.d/contoller
# 
# 4. Test it out
#    /etc/init.d/controller start
# 
# 5. Enable the script at bootup 
# chkconfig --add controller 
# chkconfig --level 2345 controller on 
#         or
# update-rc.d -f controller start 99 2 3 4 5 .
#
# Source function library.
#. /etc/init.d/functions
# The user account that will run this Controller instance
APPD_RUNTIME_USER="appd"

# DO NOT EDIT BEYOND THIS LINE
RETVAL=$?

setup () {
	PRG="$0"

	while [ -h "$PRG" ]; do
		ls=`ls -ld "$PRG"`
		link=`expr "$ls" : '.*-> \(.*\)$'`
		if expr "$link" : '/.*' > /dev/null; then
			PRG="$link"
		else
			PRG=`dirname "$PRG"`/"$link"
		fi
	done

	# Get standard environment variables
	PRGDIR=`dirname "$PRG"`

	#Absolute path
	PRGDIR=`cd "$PRGDIR" ; pwd -P`
}

stop() {
	if [ -x "$PRGDIR/controller.sh" ]; then
		/bin/su $APPD_RUNTIME_USER $PRGDIR/controller.sh stop
		RETVAL=$?
	else
		echo "Startup script $PRGDIR/controller.sh doesn't exist or is not executable."
		RETVAL=255
	fi
}

status() {
	STATUS=`ps -ef |grep glassfish |grep -v grep`
        if [ $? -eq 0 ]
           then
               echo "AppDynamics Controller is running"
           else
               echo "AppDynamics Controller is NOT running"
           fi
}

start() {
	if [ -x "$PRGDIR/controller.sh" ]; then
		/bin/su $APPD_RUNTIME_USER $PRGDIR/controller.sh start
		RETVAL=$?
	else
		echo "Startup script $PRGDIR/controller.sh doesn't exist or is not executable."
		RETVAL=255
	fi
}

setup

case "$1" in
	start)
		start
		;;
	stop)
		stop
		;;
	restart)
		stop
		start
		;;
	status)
		status
		;;
	*)
		echo $"Usage: $0 {start|stop|restart|status}"
		exit 1
		;;
esac

exit $RETVAL
