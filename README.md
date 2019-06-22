# SABviaCLI
SABnzbd via CLI

A few notes and code snippets to read SABnzbd from the CLI. Useful if a WebGUI is not possible


### Get the API key from a running SABnzbd (which has no GUI password set!)

```
$ curl -s 'http://192.168.1.1:8080/config/general/' | grep "API Key QR"  | head -1 | awk -F\" '{ print $6 }'

8da6c9215826c05ebac0c9526697cb46
```

