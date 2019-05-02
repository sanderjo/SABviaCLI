#!/bin/bash

#APIKEY="8cf72df3a90ac9652a4d58a48f028352"

#APIKEY=`grep ^api_key ~/.sabnzbd/sabnzbd.ini | awk '{ print$NF }'`
APIKEY=$(awk '/^api_key/ { print $NF }'  ~/.sabnzbd/sabnzbd.ini)

echo "API Key found:" $APIKEY

#lynx --dump 'http://127.0.0.1:8080/sabnzbd/api?output=json&apikey=8cf72df3a90ac9652a4d58a48f028352&mode=history' | python3 -m json.tool  | grep -B1 nzb_name | grep '"name"'

#lynx --dump 'http://127.0.0.1:8080/sabnzbd/api?output=json&apikey=$APIKEY&mode=history' | python3 -m json.tool  | grep -B1 nzb_name | grep '"name"'

#URL='http://127.0.0.1:8080/sabnzbd/api?output=json&apikey=8cf72df3a90ac9652a4d58a48f028352&mode=history'

#URL1='http://127.0.0.1:8080/sabnzbd/api?output=json&apikey=8cf72df3a90ac9652a4d58a48f028352'
#URL2='&mode=history'


BASEURL='http://127.0.0.1:8080/sabnzbd/api?output=json&apikey='
BASEURL+="$APIKEY"

echo "QUEUE"
lynx --dump $BASEURL"&mode=queue" | python3 -m json.tool | grep filename

echo "HISTORY"
lynx --dump $BASEURL"&mode=history" | python3 -m json.tool  | grep -B1 nzb_name | grep '"name"'
