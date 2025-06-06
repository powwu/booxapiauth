## To generate code:
https://push.boox.com/api/1/auth/qrcode/create
With request headers:
POST /api/1/auth/qrcode/create HTTP/1.1
Host: push.boox.com
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:139.0) Gecko/20100101 Firefox/139.0
Accept: application/json, text/plain, */*
Accept-Language: en-US,en;q=0.5
Accept-Encoding: gzip, deflate, br, zstd
Content-Type: application/json
Content-Length: 20
Referer: https://push.boox.com/
Origin: https://push.boox.com
Sec-Fetch-Dest: empty
Sec-Fetch-Mode: no-cors
Sec-Fetch-Site: same-origin
Priority: u=0
Connection: keep-alive
Pragma: no-cache
Cache-Control: no-cache

This returns json with `data` column being the URL to encode. You can encode this directly, without https:// or anything.

## To check code after scanning:
https://push.boox.com/api/1/auth/qrcode/check?clientType=web&qrcodeId=00000000000000000000000000000000

Codes expire after 3 minutes. Codes are checked every 1.5 seconds.
When scanned, the response for check has two changes:
- data.scanned is set to "yes"
- data.userInfo is populated.
