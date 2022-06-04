#!/bin/bash
echo "> Auto deploy starting...."

CURRENT_PID=`cat ui.pid`

echo "> PID :: $CURRENT_PID"

if [ -z $CURRENT_PID ]; then
echo "> There is no running application."

else
    echo "> kill -9 $CURRENT_PID"
    kill -9 $CURRENT_PID
    sleep 10
fi

echo "> Do Deploy..."
nohup java -jar /home/ubuntu/${PJ_NAME}-0.0.1-SNAPSHOT.jar >> running.log &

cat running.log

echo "> Deploy Complete ! !"
