# mocorunner-debian
Debian package for mocorunner. Moco is an easy setup stub framework.

For more details of how moco works: https://github.com/dreamhead/moco

## Usage

```
$ mocorunner start -p 9876 -c moco-config.json
```

moco-config.json

```
[
  {
    "request": {
      "uri": "/"
    },
    "response": {
      "status": 200,
      "json": {
        "success": false,
        "message": {
          "MessageType": "missing OR invalid",
          "RecipientAddress": "invalid"
        }
      }
    }
  }
]
```

A call to the endpoint ```/``` will return the json payload under the ```json``` field.

```
$ curl -v localhost:9876/
```

```
* Rebuilt URL to: localhost:9876/
*   Trying 127.0.0.1...
* Connected to localhost (127.0.0.1) port 9876 (#0)
> GET / HTTP/1.1
> Host: localhost:9876
> User-Agent: curl/7.47.0
> Accept: */*
> 
< HTTP/1.1 200 OK
< Content-Length: 93
< Content-Type: application/json; charset=utf-8
< 
* Connection #0 to host localhost left intact
{"success":false,"message":{"MessageType":"missing OR invalid","RecipientAddress":"invalid"}}
```