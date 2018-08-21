#!/bin/bash

#  Requirements:

#  $ brew cask install xquartz

#  Set Up

#  Open xquartz
#  Go to Preference / Security tab
#  Make sure "Allow connections from network clients" is checked
#  Close xquartz

#  Optional

#  in your code optionally add the following
#  width=((ENV["SCREENWIDTH"] || "1280").to_i*0.5).round
#  height=((ENV["SCREENHEIGHT"] || "800").to_i*0.8).round
#  $stdout.puts "Using window size "+width.to_s+" x "+height.to_s
#  Capybara::Selenium::Driver.new(app, browser: :chrome, args: ["--window-size="+width.to_s+","+height.to_s])

#  Verify:

#  Be sure to modify the IMAGE variable below

#  Assumptions:

#  your code base has an env.env file with all required environment variable defined in K=V format
#  your code base has a "spec" directory that is in the image at /app
#  your code base has a "config" directory that is in the image at /app

#  Procedure:

#  run the script from the code base directory where env.env file, spec directory, and config directory exist


#  set the image name
IMAGE=quay.octanner.io/developer/courierui:latest

#  open xquartz
open -a xquartz >/dev/null 2>&1
sleep 5


#  Set the display so that the xhost and keyboard reset work
export DISPLAY=:0
export PATH=$PATH:/opt/X11/bin


#  get current screen geometry settings 
WIDTH=`xrandr 2> /dev/null | grep "\*" | awk {'print $1}' | cut -d 'x' -f 1`
sleep 1
HEIGHT=`xrandr 2> /dev/null  | grep "\*" | awk {'print $1}' | cut -d 'x' -f 2`
echo "$WIDTH x $HEIGHT"

#  Make sure XQuartz is running
osascript <<BITEME
repeat until application "XQuartz" is running
        delay 1
end repeat
BITEME

#  Get the current IP to send the browser
export IP=$(ifconfig en0 | grep inet | awk '$1=="inet" {print $2}')

#  Allow connections from that IP address
xhost + $IP

#  Reset the keyboard, otherwise some characters are interpreted as control characters
setxkbmap -rules evdev -model pc104 -layout us


sleep 5
LOCALDIR=`pwd`
echo $IMAGE
echo $LOCALDIR

#  Run your tests from docker
docker run  --env-file env.env --privileged --rm -v /tmp/.X11-unix:/tmp/.X11-unix -v $LOCALDIR/spec:/app/spec -v $LOCALDIR/config:/app/config  -e DISPLAY=$IP:0 -e SCREENWIDTH=$WIDTH -e SCREENHEIGHT=$HEIGHT --name chrome $IMAGE

#  Shut down xquartz
osascript <<DERP
try
   with timeout of 0.75 seconds
       quit application "XQuartz"
   end timeout
on error number e
   if e is -1712 then
       activate application "XQuartz"
       tell application "System Events"
           tell application process "XQuartz"
               keystroke return
           end tell
       end tell
   end if
end try
DERP
