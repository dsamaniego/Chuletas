# Keytab y levana.

## CERTIFICADOS

curl -k -X POST -u oper -H "Content-Type: application/json" -d "@certificate.json" https://levana.marathon.l4lb.$(dnsdomainname)/v2/certificates

$ cat certificate.json
{   
  "fqdn": "sherlock.marathon.l4lb.play01.daas.gl.igrupobbva",   
  "altNames": [],   
  "secretKey": "platform/gl/play/datio/sherlock/sherlock/certificate/server",
  "force":true,
  "server":true
}

## GENERACION KEYTAB

curl -k -H "Content-Type: application/json" -X POST -i -u oper https://levana.marathon.l4lb.$(dnsdomainname)/v2/keytab \
-d '{
"principal": "E052536",
"appendRealm": false,
"secretKey": "people/kerberos/E052536",
"force":true,
"changeKeys": {
       "keytab": "E052536_keytab",
       "principal": "E052536_principal"}
}'

### Mas información
[https://datiobd.atlassian.net/wiki/spaces/CPPR/pages/87499339/Levana+Secrets+API]
