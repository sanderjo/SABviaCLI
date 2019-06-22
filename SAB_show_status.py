#!/usr/bin/env python3


import sys
import json


try:
	ip = sys.argv[1]
except:
	ip = '127.0.0.1'

url = 'http://' + ip + ':8080/sabnzbd/config/general/'
print(url)

# Try to find API Key via WebGUI (only works if no password is set)
import urllib.request
x = urllib.request.urlopen(url)
apikey = ""
for line in x.readlines():
	if b"API Key QR Code" in line:
		apikey = line.decode('utf-8').split('"')[5]
		print("apikey found:", apikey)
		break

if apikey == "" and ip == '127.0.0.1':
	# no apikey found
	# Cause: maybe the local SABnzbd' WebGUI has a password set, so
	# let's try the local sabnzbd.ini
	try:
		from os.path import expanduser
		home = expanduser("~")
		sabini = home + "/.sabnzbd/sabnzbd.ini" # Linux / Posix only
		# print(sabini)
		with open(sabini) as search:
			for line in search:
				if line.find("api_key") == 0 :
					apikey = line.rstrip().split()[-1]
					print("API key from sabnzbd.ini:", apikey)
					break
	except:
		print("sabnzbd.ini not found")



# queue:
print("\nQueue contents:")
baseurl="http://" + ip + ":8080/sabnzbd/api?output=json&apikey=" + apikey
queueurl = baseurl + "&mode=queue"
print("queue URL is", queueurl)

jsonoutput = urllib.request.urlopen(queueurl).read()
y = json.loads(jsonoutput.decode('utf-8'))
print("Queue status:", y["queue"]["status"]) 
print("Queue MB Left:", y["queue"]["mbleft"]) 
for i in y["queue"]["slots"] :
	print("Queue: ", i["filename"], i["sizeleft"])


# History:
print("\nHistory contents:")
historyurl = baseurl + "&mode=history" 
print("History URL is", historyurl)

jsonoutput = urllib.request.urlopen(historyurl).read()
y = json.loads(jsonoutput.decode('utf-8'))
for i in y["history"]["slots"] :
	if i["fail_message"] == "":
		print("OK:     ",end = '')
	else :
		print("NOK:    ",end = '') 
	print(i["name"] )


sys.exit(0)


