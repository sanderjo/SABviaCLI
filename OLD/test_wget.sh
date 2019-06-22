#!/usr/bin/env bash


#wget -o /dev/null  -O-  'http://127.0.0.1:8080/sabnzbd/api?output=json&apikey=8cf72df3a90ac9652a4d58a48f028352&mode=history' |  python3 -m json.tool  | grep -B1 nzb_name | grep '"name"'


URL='http://127.0.0.1:8080/sabnzbd/api?output=json&apikey=8cf72df3a90ac9652a4d58a48f028352&mode=history'


BASEURL='http://127.0.0.1:8080/sabnzbd/api?output=json&apikey=8cf72df3a90ac9652a4d58a48f028352'
URL=$BASEURL'&mode=history'
echo $URL

wget -o /dev/null  -O- $URL | python3 -m json.tool  | grep -B1 nzb_name | grep '"name"'
