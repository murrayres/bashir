#!/bin/sh

if [ -z "$APP_PATH" ]; then
echo You need to pass in APP_PATH
exit 1
fi


bundle exec parallel_rspec spec/features/${APP_PATH} -o '--format json --out result.json'
RESULT=$?
if [ -f result.json ]; then
  if [ ! -z "${DIAGNOSTIC_RESULTS_URL}" ]; then
     curl -s -X POST -d @./result.json $DIAGNOSTIC_RESULTS_URL/$DIAGNOSTIC_RUNID
  fi
fi
exit $RESULT


