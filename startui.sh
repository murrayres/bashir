#!/bin/bash


source /opt/bin/functions.sh

export GEOMETRY="$SCREEN_WIDTH""x""$SCREEN_HEIGHT""x""$SCREEN_DEPTH"

function shutdown {
  kill -s SIGTERM $NODE_PID
  wait $NODE_PID
}

if [ ! -z "$SE_OPTS" ]; then
  echo "appending selenium options: ${SE_OPTS}"
fi

SERVERNUM=$(get_server_num)

rm -f /tmp/.X*lock

xvfb-run -n $SERVERNUM --server-args="-screen 0 $GEOMETRY -ac +extension RANDR" \
  java ${JAVA_OPTS} -jar /opt/selenium/selenium-server-standalone.jar \
  ${SE_OPTS} &
NODE_PID=$!

trap shutdown  SIGTERM SIGINT
if [ -z "$APP_PATH" ]; then
echo You need to pass in APP_PATH
exit 1
else
    bundle exec parallel_rspec spec/features/${APP_PATH}
    export RESULT=$? 
    echo $RESULT
    kill $NODE_PID
    exit $RESULT
fi
exit $RESULT
wait $NODE_PID
exit $RESULT

