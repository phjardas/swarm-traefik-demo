To create the certificate:

```
openssl req -x509 -newkey rsa:4096 -nodes -subj '/CN=localhost' -keyout localhost.key -out localhost.crt -days 365
```
