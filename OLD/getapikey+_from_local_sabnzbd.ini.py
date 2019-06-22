#!/usr/bin/env python3

# Local file search

'''
$ cat ~/.sabnzbd/sabnzbd.ini | grep -i -e ^api_key
api_key = 8cf72df3a90acdfadsf8a48f028352
'''

try:
    from os.path import expanduser
    home = expanduser("~")
    sabini = home + "/.sabnzbd/sabnzbd.ini" # Linux / Posix only
    # print(sabini)
    with open(sabini) as search:
        for line in search:
            if line.find("api_key") == 0 :
                apikey = line.rstrip().split()[-1]
		print apikey
except:
    print("sabnzbd.ini not found")


host = '127.0.0.1'
port = '8080'
