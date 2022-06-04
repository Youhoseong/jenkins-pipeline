#!/bin/bash
echo "Auto Deploy Starting...."

CURRENT_PID=`cat ui.pid`

echo "$CURRENT_PID"

if [ -z $CURRENT_PID ]; then
echo "> There is no running application."

else
    echo "> kill -9 $CURRENT_PID"
    kill -9 $CURRENT_PID
    sleep 10
fi

echo "> Do Deploy..."
nohup java -jar ${PJ_NAME}-0.0.1-SNAPSHOT.jar >> running.log &
echo "> Deploy Complete ! !"
