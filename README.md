# SABviaCLI
SABnzbd via CLI

A CLI tool to show the Queue and History of a local or remote SABnzbd. Useful if a WebGUI is not possible, for example if you only have access via SSH.

```
$ ./SAB_show_status.py 192.168.1.1 
http://192.168.1.1:8080/sabnzbd/config/general/
apikey found: 8da6c9215826c05ebac0c9526697cb46

Queue contents:
queue URL is http://192.168.1.1:8080/sabnzbd/api?output=json&apikey=8da6c9215826c05ebac0c9526697cb46&mode=queue
Queue status: Downloading
Queue MB Left: 83.18
Queue:  reftestnzb 83.2 MB

History contents:
History URL is http://192.168.1.1:8080/sabnzbd/api?output=json&apikey=8da6c9215826c05ebac0c9526697cb46&mode=history
OK:     Snavel. (2000) DVDRip XVID NoGroup
OK:     Snavel. (2000) DVD NoGroup
NOK:    Snavel 2000 720p BDRip AC3 x264 MacGuffin
NOK:    Snavel.2000.720p.BRRip.x264.AAC-MOBBit
OK:     Snavel 2000 DVDRip XviD AC3 - KINGDOM
OK:     Show Me Money (1998).Swedish.DVD.MP3-NoGroup
OK:     Show.Me.Money.1998.DVDRip.DD2.0.x264-KAT
NOK:    Walking Amal (1998) Show Me Money - 720p webrip
OK:     Castle.Lords.S02E04.FiNAL.720p.WEB.x264-TVSLiCES
OK:     Castle.Lords.S02E04.Piet.Bruinsma.Europes.Hash.King.720p.NF.WEB-DL.DD5.1.x264-NTb
```

A few notes and code snippets to read SABnzbd from the CLI.


### Get the API key from a running SABnzbd (which has no GUI password set!)

With curl:
```
$ curl -s 'http://192.168.1.1:8080/config/general/' | grep "API Key QR"  | head -1 | awk -F\" '{ print $6 }'

8da6c9215826c05ebac0c9526697cb46
```

or with wget:

```
$ wget -o /dev/null  -O- 'http://192.168.1.1:8080/sabnzbd/config/general/' |  awk -F\' '/sabSession/ { print $2 }'

8da6c9215826c05ebac0c9526697cb46
```
