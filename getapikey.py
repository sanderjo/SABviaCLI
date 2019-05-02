#!/usr/bin/env python3

'''
$ cat ~/.sabnzbd/sabnzbd.ini | grep -i -e ^api_key
api_key = 8cf72df3a90acdfadsf8a48f028352
'''

if True:
    from os.path import expanduser
    home = expanduser("~")
    sabini = home + "/.sabnzbd/sabnzbd.ini"
    with open(sabini) as search:
        for line in search:
            if line.find("api_key") == 0 :
                apikey = line.rstrip().split()[-1]

try:
    a = 0
except:
    print("Error")


host = '127.0.0.1'
port = '8080'
