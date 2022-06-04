#!/bin/bash
echo "> Auto deploy starting...."

CURRENT_PID=`cat ui.pid`

echo "> OLD APP PID :: $CURRENT_PID"

if [ -z $CURRENT_PID ]; then
    echo "> Nothing running app ! !"

else
    echo "> $CURRENT_PID will be stopped"
    kill -15 $CURRENT_PID 2> /dev/null


    limit=0
    stopped=0
    while [ "$limit" -lt 30 ]
    do
        limit=$(expr $limit + 1)
        sleep 1
        kill -0 $CURRENT_PID 2> /dev/null
        if [ $? -ne 0 ] ;then
          stopped=1
          break
        fi
    done

    if [ $stopped -eq 0 ];then
        echo "> Force stop ! !"
        kill -9 $PID
    fi
fi

echo "> Do deploy :: $1"

nohup java -jar /home/ubuntu/$1-0.0.1-SNAPSHOT.jar >> running.log &
NEW_PID=$!
echo "> NEW APP PID :: $NEW_PID"

cat running.log

echo "> Deploy Complete ! !"
