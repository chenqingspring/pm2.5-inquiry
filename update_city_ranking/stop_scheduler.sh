#!/bin/sh
PID=`ps -ef | grep ruby | awk '{ print $2 }'`
if [ "$PID" != "" ]; then
  echo "stopping scheduler..."
  kill -9 $PID
  echo "scheduler stopped"
fi