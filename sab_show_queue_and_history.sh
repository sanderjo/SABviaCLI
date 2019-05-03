#!/bin/bash

# Get Queue and History from the local SABnzbd

# Try to get APIKEY:
# ... from the ini file
echo "Trying to find APIKEY via sabnzbd.ini"
APIKEY=$(awk '/^api_key/ { print $NF }'  ~/.sabnzbd/sabnzbd.ini 2>/dev/null )
if [ -n "$APIKEY" ]; then
  echo "API Key found via ini file:" $APIKEY
else
  # ... or else via the webinterface
  echo "Trying via webinterface"
  #APIKEY=$(lynx --dump 'http://127.0.0.1:8080/sabnzbd/config/general/' | grep API | awk '{ print $3 }')
  APIKEY=$(wget -o /dev/null  -O- 'http://127.0.0.1:8080/sabnzbd/config/general/' |  awk -F\' '/sabSession/ { print $2 }')
  if [ -n "$APIKEY" ]; then
    echo "API Key found via webinterface" $APIKEY
  else
    echo "no API Key found!!!"
    exit
  fi
fi
# APIKEY should now be something like "8cf72df3a90ac9652a4d58a48f028352"

#lynx --dump 'http://127.0.0.1:8080/sabnzbd/api?output=json&apikey=8cf72df3a90ac9652a4d58a48f028352&mode=history' | python3 -m json.tool  | grep -B1 nzb_name | grep '"name"'
#lynx --dump 'http://127.0.0.1:8080/sabnzbd/api?output=json&apikey=$APIKEY&mode=history' | python3 -m json.tool  | grep -B1 nzb_name | grep '"name"'

BASEURL='http://127.0.0.1:8080/sabnzbd/api?output=json&apikey='
BASEURL+="$APIKEY"

echo "QUEUE"
#lynx --dump $BASEURL"&mode=queue" | python3 -m json.tool | grep filename
URL=$BASEURL"&mode=queue"
echo $URL
wget -o /dev/null -O- $URL | python -m json.tool | grep filename


echo "HISTORY"
#lynx --dump $BASEURL"&mode=history" | python3 -m json.tool  | grep -B1 nzb_name | grep '"name"'
URL=$BASEURL"&mode=history"
echo $URL
wget -o /dev/null -O- $URL | python -m json.tool  | grep -B1 nzb_name | grep '"name"'
