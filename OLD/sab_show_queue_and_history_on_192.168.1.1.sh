#!/bin/bash

# Get Queue and History from the local SABnzbd



if [ -z "$1" ]
then
      echo "IP not set, so using local IP"
      IP="127.0.0.1"
else
      echo "IP set, so using that"
      IP=$1
fi

URL="http://$IP:8080/sabnzbd/config/general/"
echo "URL is" $URL
wget -o /dev/null -O- $URL |  awk -F\' '/sabSession/ { print $2 }'


# Try to get APIKEY:

  echo "Trying via webinterface"
  #APIKEY=$(lynx --dump 'http://127.0.0.1:8080/sabnzbd/config/general/' | grep API | awk '{ print $3 }')
  APIKEY=$(wget -o /dev/null  -O- $URL |  awk -F\' '/sabSession/ { print $2 }')
  if [ -n "$APIKEY" ]; then
    echo "API Key found via webinterface" $APIKEY
  else
    echo "no API Key found!!!"
    exit
  fi


# APIKEY should now be something like "8cf72df3a90ac9652a4d58a48f028352"

#lynx --dump 'http://127.0.0.1:8080/sabnzbd/api?output=json&apikey=8cf72df3a90ac9652a4d58a48f028352&mode=history' | python3 -m json.tool  | grep -B1 nzb_name | grep '"name"'
#lynx --dump 'http://127.0.0.1:8080/sabnzbd/api?output=json&apikey=$APIKEY&mode=history' | python3 -m json.tool  | grep -B1 nzb_name | grep '"name"'

BASEURL="http://$IP:8080/sabnzbd/api?output=json&apikey="
BASEURL+="$APIKEY"

echo "QUEUE contains"
#lynx --dump $BASEURL"&mode=queue" | python3 -m json.tool | grep filename
URL=$BASEURL"&mode=queue"
echo $URL
wget -o /dev/null -O- $URL | python -m json.tool | grep filename


echo "HISTORY shows"
#lynx --dump $BASEURL"&mode=history" | python3 -m json.tool  | grep -B1 nzb_name | grep '"name"'
URL=$BASEURL"&mode=history"
echo $URL
wget -o /dev/null -O- $URL | python -m json.tool  | grep -B1 -e  nzb_name -e fail_message | grep -e '"name"' -e fail_message

