Nos conectamos al crossdata (para lo que tendremos que ir al DC/OS y ver el nodo en el que se está ejecutando el XData.
'''
jhicar@jhicar:~$ aliSebis 192.168.193.54@live.es
DISCLAIMER: Your session is being recorded. Session ID: da082379-80cb-32ee-b0a9-585bd2a949ab
[XE78726@agent-f1-38 LIVE02 ~]$ sudo su -
[root@agent-f1-38 LIVE02 ~]# docker ps
CONTAINER ID        IMAGE                                                                                                             COMMAND                   CREATED             STATUS              PORTS               NAMES
7f7e28c3d4b9        nexus.daas.live.es.ether.igrupobbva/repository/es-docker/stratio/intelligence-spark-executor:0.5.0-upgrade2-RC1   "/bin/sh -c ' \"/opt/s"   2 hours ago         Up 2 hours                              mesos-9c0c99d7-975a-4507-8786-2b570411a106-S113.c4dca0f5-646a-4506-b521-4323d0a31cf0
cfc573717e5e        registry-datio-level1-live-es.ether.iaas.igrupobbva/datio-spark/engine/global/hehhf/hehhf_sherlock:1.0.3          "/entrypoint.sh"          4 days ago          Up 4 days                               mesos-9c0c99d7-975a-4507-8786-2b570411a106-S113.e70a8ef4-85ed-4fef-8c67-a2e618e3a413
071759c4b979        nexus.daas.live.es.ether.igrupobbva/repository/es-docker/stratio/crossdata-scala211:2.11.1                        "/bin/sh -c 'CROSSDAT"    5 days ago          Up 5 days                               mesos-9c0c99d7-975a-4507-8786-2b570411a106-S113.99356268-4bb3-4ea7-8862-093094e43f14
f99f8a8ab190        quay.io/calico/node:v1.1.3                                                                                        "start_runit"             3 weeks ago         Up 3 weeks                              calico-node
[root@agent-f1-38 LIVE02 ~]# docker exec -it 071759c4b979 bash
root@agent-f1-38:/# cd /opt/sds/crossdata/bin
root@agent-f1-38:/opt/sds/crossdata/bin# ./crossdata-shell --user xesxdprcm1l --host xd-prcm-sandbox.marathon.l4lb.live02.daas.es.igrupobbva:443
CROSSDATA_SHELL_HOME = /opt/sds/crossdata
CROSSDATA_SHELL_CONF = /etc/sds/crossdata/shell
CROSSDATA_SHELL_LIB  = /opt/sds/crossdata/lib
CROSSDATA_SHELL_BIN  = /opt/sds/crossdata/bin
CROSSDATA_SHELL_LOG_OUT  = /opt/sds/crossdata/bin/crossdata-shell.out
CROSSDATA_SHELL_LOG_ERR  = /opt/sds/crossdata/bin/crossdata-shell.err
CROSSDATA_SHEL_PID  = /opt/sds/crossdata/crossdata-shell.pid
CROSSDATA_SHELL_HOME = /opt/sds/crossdata
CROSSDATA_SHELL_CONF = /etc/sds/crossdata/shell
CROSSDATA_SHELL_LIB  = /opt/sds/crossdata/lib
CROSSDATA_SHELL_BIN  = /opt/sds/crossdata/bin
CROSSDATA_SHELL_LOG_OUT  = /opt/sds/crossdata/bin/crossdata-shell.out
CROSSDATA_SHELL_LOG_ERR  = /opt/sds/crossdata/bin/crossdata-shell.err
CROSSDATA_SHEL_PID  = /opt/sds/crossdata/crossdata-shell.pid
SLF4J: Class path contains multiple SLF4J bindings.
SLF4J: Found binding in [jar:file:/opt/sds/crossdata/lib/crossdata-driver_2.11-2.11.1-jar-with-dependencies.jar!/org/slf4j/impl/StaticLoggerBinder.class]
SLF4J: Found binding in [jar:file:/opt/sds/crossdata/lib/crossdata-server_2.11-2.11.1-jar-with-dependencies.jar!/org/slf4j/impl/StaticLoggerBinder.class]
SLF4J: See http://www.slf4j.org/codes.html#multiple_bindings for an explanation.
SLF4J: Actual binding is of type [org.slf4j.impl.Log4jLoggerFactory]
ScriptEngineManager providers.next(): javax.script.ScriptEngineFactory: Provider scala.tools.nsc.interpreter.IMain$Factory not found
2018-10-24T13:29:03.602Z INFORMATIONAL [CrossdataDriver] - - com.stratio.crossdata.driver.shell.BasicShell$ {"@timestamp":"2018-10-24T13:29:03.602Z","@message":"user: xesxdprcm1l timeout(seconds): Duration.Inf","@data":{}}
2018-10-24T13:29:04.180Z INFORMATIONAL [CrossdataDriver] - - com.stratio.crossdata.driver.shell.BasicShell$ {"@timestamp":"2018-10-24T13:29:04.180Z","@message":"No previous history found","@data":{}}
2018-10-24T13:29:05.343Z INFORMATIONAL [CrossdataDriver] - - akka.event.slf4j.Slf4jLogger$$anonfun$receive$1 {"@timestamp":"2018-10-24T13:29:05.343Z","@message":"Slf4jLogger started","@data":{}}
2018-10-24T13:29:05.448Z INFORMATIONAL [CrossdataDriver] - - org.slf4j.helpers.MarkerIgnoringBase {"@timestamp":"2018-10-24T13:29:05.448Z","@message":"Starting remoting","@data":{}}
2018-10-24T13:29:05.598Z INFORMATIONAL [CrossdataDriver] - - org.slf4j.helpers.MarkerIgnoringBase {"@timestamp":"2018-10-24T13:29:05.598Z","@message":"Remoting started; listening on addresses :[akka.tcp://CrossdataServerCluster@127.0.0.1:43421]","@data":{}}
2018-10-24T13:29:05.599Z INFORMATIONAL [CrossdataDriver] - - org.slf4j.helpers.MarkerIgnoringBase {"@timestamp":"2018-10-24T13:29:05.599Z","@message":"Remoting now listens on addresses: [akka.tcp://CrossdataServerCluster@127.0.0.1:43421]","@data":{}}
2018-10-24T13:29:06.280Z INFORMATIONAL [CrossdataDriver] - - com.stratio.crossdata.common.security.KeyStoreUtils$ {"@timestamp":"2018-10-24T13:29:06.280Z","@message":"Valid keystore loaded from /etc/sds/crossdata/security/xd-prcm-sandbox.jks","@data":{}}
2018-10-24T13:29:06.284Z INFORMATIONAL [CrossdataDriver] - - com.stratio.crossdata.common.security.KeyStoreUtils$ {"@timestamp":"2018-10-24T13:29:06.284Z","@message":"Valid truststore loaded from /etc/sds/crossdata/security/truststore.jks","@data":{}}
java.lang.Exception: Impossible to obtain session from server. Do you have valid credentials?
	at com.stratio.crossdata.driver.HttpDriver$$anonfun$openSession$1.applyOrElse(HttpDriver.scala:88)
	at com.stratio.crossdata.driver.HttpDriver$$anonfun$openSession$1.applyOrElse(HttpDriver.scala:86)
	...
Caused by: com.stratio.crossdata.driver.exceptions.TLSInvalidAuthException: Possible invalid authentication (check if you have a valid TLS certificate configured in your driver).
	at com.stratio.crossdata.driver.exceptions.TLSInvalidAuthException$.apply(TLSInvalidAuthException.scala:11)
	... 
Caused by: javax.net.ssl.SSLException: Received fatal alert: certificate_unknown
	at sun.security.ssl.Alerts.getSSLException(Alerts.java:208)
	at sun.security.ssl.SSLEngineImpl.fatal(SSLEngineImpl.java:1666)
	...
2018-10-24T13:29:07.269Z INFORMATIONAL [CrossdataDriver] - - com.stratio.crossdata.driver.shell.BasicShell$ {"@timestamp":"2018-10-24T13:29:07.269Z","@message":"Saving history...","@data":{}}
2018-10-24T13:29:07.273Z INFORMATIONAL [CrossdataDriver] - - com.stratio.crossdata.driver.shell.BasicShell$ {"@timestamp":"2018-10-24T13:29:07.273Z","@message":"Closing shell...","@data":{}}
Couldn't start Crossdata session: Impossible to obtain session from server. Do you have valid credentials?
2018-10-24T13:29:07.276Z INFORMATIONAL [CrossdataDriver] - - org.slf4j.helpers.MarkerIgnoringBase {"@timestamp":"2018-10-24T13:29:07.276Z","@message":"Starting coordinated shutdown from JVM shutdown hook","@data":{}}
2018-10-24T13:29:07.305Z INFORMATIONAL [CrossdataDriver] - - org.slf4j.helpers.MarkerIgnoringBase {"@timestamp":"2018-10-24T13:29:07.305Z","@message":"Shutting down remote daemon.","@data":{}}
2018-10-24T13:29:07.307Z INFORMATIONAL [CrossdataDriver] - - org.slf4j.helpers.MarkerIgnoringBase {"@timestamp":"2018-10-24T13:29:07.307Z","@message":"Remote daemon shut down; proceeding with flushing remote transports.","@data":{}}
2018-10-24T13:29:07.333Z INFORMATIONAL [CrossdataDriver] - - org.slf4j.helpers.MarkerIgnoringBase {"@timestamp":"2018-10-24T13:29:07.333Z","@message":"Remoting shut down","@data":{}}
2018-10-24T13:29:07.333Z INFORMATIONAL [CrossdataDriver] - - org.slf4j.helpers.MarkerIgnoringBase {"@timestamp":"2018-10-24T13:29:07.333Z","@message":"Remoting shut down.","@data":{}}
```

Comprobamos cómo están instalados los certificados, siguiendo el manual de instalación del XData, a ver si se ha hecho bien.

Para ver si están bien, hay que irse a vault.
```
jhicar@jhicar:~$ aliSebis gosec2@live.es
DISCLAIMER: Your session is being recorded. Session ID: 8dd17fe8-37a1-ed32-0ba0-2305cda4a135
[XE78726@gosec2 LIVE02 ~]$ sudo su -
Último inicio de sesión:mié oct 24 12:55:01 UTC 2018en pts/0
[root@gosec2 LIVE02 ~]# export VAULT_ADDR="https://vault.service.eos.$(dnsdomainname):8200" && export VAULT_TOKEN="7d2255a4-923b-0505-316c-948d7a760412"
[root@gosec2 LIVE02 ~]# vault list userland/certificates/
Keys
----
doip
ds-doip-sandbox
xd-doip-sandbox
...
xd-prcm-sandbox
xd-prcm-sandbox-client
...



[root@gosec2 LIVE02 ~]# vault list userland/certificates/xd-prcm-sandbox
No value found at userland/certificates/xd-prcm-sandbox/
[root@gosec2 LIVE02 ~]# vault list userland/certificates/xd-prcm-sandbox-client
No value found at userland/certificates/xd-prcm-sandbox-client/
[root@gosec2 LIVE02 ~]# vault read userland/certificates/xd-prcm-sandobox
No value found at userland/certificates/xd-prcm-sandobox
[root@gosec2 LIVE02 ~]# vault read userland/certificates/xd-prcm-sandbox
Key                	Value
---                	-----
refresh_interval   	768h0m0s
xd-prcm-sandbox_crt	-----BEGIN CERTIFICATE-----MIIFJzCCAw+gAwIBAgIQHMzznozUyrlPOg61+budqDANBgkqhkiG9w0BAQsFADAmMQ0wCwYDVQQKEwRCQlZBMRUwEwYDVQQDEwxCQlZBIENBIFJhaXowHhcNMTUxMDA2MTUxMzA0WhcNMzUxMDA2MTUxNjM0WjAmMQ0wCwYDVQQKEwRCQlZBMRUwEwYDVQQDEwxCQlZBIENBIFJhaXowggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQDFMGPyEAi/YOUbhnQpvMZqAiCq8f592W/bVCeDOgmUXOmRDtacsybaI+pAnz7ERLr1morzqmtv0idfLDEpM1hDhiswgG1BHu/Bp4BAgPjC81AhUls9RyQFHQiaqJXdTuSXoDKSQVl1mylbirg/trSNr0rk1g99IEoQj6c2RjSRSqOLXBMddBgnrn3mVxhgkebeQLXnwGwHDNwftpxOWcdq5Jo9B+8pXcaPENI/oQ+3RXkZaQ5rgOlVToLoMync+9vuuz+HJXZpb68R8OJZZ7ko4Aaz4VOojIg7Jf8rt4tL7bHKaZBpIO3wrFi/fsZWpXanGFWI7S+WBPFw31asCxZ/4jDLQmeXq9IzIrcN2nw2zK5gsY6FAgVPsIggu2jHVsFWUqHMjsTYLCKgDu2egfg8NZvDlXVvgUe5N4R32FD3YJo257sUpgk2Q9YJ59/65EjlDos3Mu0pqxDWdcL73lMBCuFexsWGHuRD6f2/N9+RS6TPyh2RjLIBLL+2BUg2j7Q+mWZ1vslUwSFVK66twDv5tWw2YriH6PRwM2WOJ3JfCfkbHO6eQt5vDLjmLM7vNKWeoQiIZYIkgLxur8C5aQib3IkR0/wfldnjVKV6vaBS4GUk2Bt2wHx4uf3GfEUJaw/Y07CLaRFlEUxk0vhViJbwv2jEFv8h3ruOWJhz9iV9NwIDAQABo1EwTzALBgNVHQ8EBAMCAYYwDwYDVR0TAQH/BAUwAwEB/zAdBgNVHQ4EFgQUmD0kaafvvXtmbYaqIpRyMcZKA4YwEAYJKwYBBAGCNxUBBAMCAQAwDQYJKoZIhvcNAQELBQADggIBAKeoNm1vxPZvk2nYEo1v+AbE8E5WZGjihZa4pYfEGOavI08pMKf71lLfCjbls73DpbU7vYBPGiQw/VCvrrmjgCQZoEav7maX6RUo1XJ8dNhSsv+fG3nEc6qstN2WxLqcmnbFORoiPjVBrV9A3UdxL3XbmjH3ZrLqYuvXedBSzwGkoMcUX88YrdUGC2Vj/ApxCDSKCZMpfeGOu4cGpVPbvuIG7sC8Gdv2bKZn/6oe54NKM5IwgqKxxlE/J7g1Q4PmT7BTQcJrUwU/TniQYs0UWT8MFLw5rlqLrI6smTNyHpay8FYJSj4ANJZTiXhc3lKXv26rZAr0mWcSnDatrWmex13YrwRAtxAOi7Ve8fYQcw0Ms7p8P9qQ8fqjAgS1E5/rh189o5GJwOxPTPy+0xIiL9BfX/vR4Z+mrGgleK+k36RCAYWCj1yibhYn8IEOhlcOqfTSxXN1vtrxeJF/xXVFr0H3qn3qxAdkvtka2AJtUOCR/OQ2ZQMwejb3/M1zqkzJfZ3qHwCji7CDrVet48HmAWU7RLNNeptUNghkdUqi7DNqWk5AylU9AiWxMNZDBI45e3hVnUNkygIM3Hyni14VwFbPh8BJMHGBBOgyrwy60+fFu4VU4lY8w3GIHrq9a9ZjPytl0GN864ttiDraRG3I8vf0Mw7j1AILc6XEmEWZv1fh-----END CERTIFICATE----------BEGIN CERTIFICATE-----MIIFhTCCA22gAwIBAgITdgAAAAJmg+wOkYW2IQAAAAAAAjANBgkqhkiG9w0BAQsFADAmMQ0wCwYDVQQKEwRCQlZBMRUwEwYDVQQDEwxCQlZBIENBIFJhaXowHhcNMTUxMDA2MTczOTQ5WhcNMjMxMDA2MTc0OTQ5WjAsMQ0wCwYDVQQKEwRCQlZBMRswGQYDVQQDExJCQlZBIENBIFNlcnZpZG9yZXMwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCx8F6fTNjE6QvLG1yczh8aRjH0U81fNy8Gpy95ADz897hRy1VcoyDTcQ8n3XjHVEMQqOSERN4nzvzJVWaWg80o0Hamd4++aAdE2HUlApMDdhscqC/9nnx9cIT9vbNFWwujNCF2E6EeCSRCKmsPz0HmQnO571MQKxumdyGaGVC2m0Mz2uZbq0ziA2mQbTjvLgRU7A5da0PZUstHSB/6KS59tBWTpGASf/BTNwvApj9q+Ixfk4z+LcyPo8PpbrnfygMSFAWfJBqrWSKLrrrGqSuU5zIMfNLiwVMk146TKFQDWrIz8VL/J9HHI8IvdgMBzn2WVQT4kdMOfxMU1IXBhII9AgMBAAGjggGkMIIBoDAQBgkrBgEEAYI3FQEEAwIBADAdBgNVHQ4EFgQUnIQmvjus3QxBGdUskHJ524S8Me4wGQYJKwYBBAGCNxQCBAweCgBTAHUAYgBDAEEwCwYDVR0PBAQDAgGGMBIGA1UdEwEB/wQIMAYBAf8CAQAwHwYDVR0jBBgwFoAUmD0kaafvvXtmbYaqIpRyMcZKA4YwbQYDVR0fBGYwZDBioGCgXoYuaHR0cDovL2NybC5pZ3J1cG9iYnZhL0NSTC9CQlZBJTIwQ0ElMjBSYWl6LmNybIYsaHR0cDovL2NybC5iYnZhLmNvbS9DUkwvQkJWQSUyMENBJTIwUmFpei5jcmwwgaAGCCsGAQUFBwEBBIGTMIGQMEcGCCsGAQUFBzAChjtodHRwOi8vY3JsLmlncnVwb2JidmEvQ1JML1YxMTI4UEtJUDAwMV9CQlZBJTIwQ0ElMjBSYWl6LmNydDBFBggrBgEFBQcwAoY5aHR0cDovL2NybC5iYnZhLmNvbS9DUkwvVjExMjhQS0lQMDAxX0JCVkElMjBDQSUyMFJhaXouY3J0MA0GCSqGSIb3DQEBCwUAA4ICAQBUSPZgHrPc5E9+cSrDMuqfadedO6nfHFzItszDYz5dD77Ws0orf1GywTj8ligm/D/nRQrZWztohX47+uesNozS8DGHFFokSo0I8VnLHTRI0Dl7/+XKavwKDNPJZMHxjkHDPSdCFEn/5WsCNMIVNMzmSJ1vz0V55+QZ/QujIxVRfb/HxDZ42BCDOw/+7BZ8k+U6dRW020b65aIgwd02afbiwxXJdliVhPVrqzWDqTLcMxdHPq19sLNjLn6AFtF6E48lYivyLGQJAxQjeE/EvrVZSJLnJTLyVYWfAIYg1y+qDC3u3WicBZHkTatCQLDo5GBvNxWE+3/PZvS2TtToHPsiES97ujfV7b2iaRD9Sh0/Ey9BgY7YIxILuJFrrBvZCsgcpftbyFBeIRHRsVP+rPR44R+D47Qo8W5NESZZc2LEVXN5bjE4z6f2b71q5dWV+Khaq5H0B+qMO8MVBh5avnQMR6z6RW97m2g2ambTp6z2uhJG8y2X84m6saRUOU7K11lMHc0JkHm60hP8Lbr4TzZTDKL+PtQ1TLBjwVuje9qa3KcN3SiBKq9gP89V+8v6pu1P5cV+Lf3A4aUwfi0C1waTHHLJhG16LA/uHFlmJSpTF2qR89xjEt7uo6HXCPSjn7lsB9iPJz/mH+VewxZCu/pfRaplGQkJFQO8OAd1mDHrwQ==-----END CERTIFICATE----------BEGIN CERTIFICATE-----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-----END CERTIFICATE-----
xd-prcm-sandbox_key	-----BEGIN RSA PRIVATE KEY-----MIIEpAIBAAKCAQEA4cPKKBHLH+lb5AZ1SMbizMIG9rR3lD1+6mp/Jr94K3X/FSnuyrN0Qfif09c11ZZuPuFAEUuzHA4ClxRWy0LPfWGPnhY9ndzYcX8gTHueqYYfxFx20TcxvEN/LES885v2CdCnfh3/3ljFqXWOJogC7NWl7Ah0u07jmj4sOCSOCE7B2N6Cw3s8oKZbhx/KvcUnjsUgDud8LPeyqeHMKDTE6x4/GRWSk0qzHqEsyINvbnGoHYuvHdDqp4iVnocV7cFze0nOdYVP1pG9muPp3g8elRl/nfJhKcZTN95sNxdOr+5MZpnAPLxz+NlrkaNBB0GE3R82KxV7O8VqfkUrIWYfMwIDAQABAoIBAQCY7jHAlt0Lzt3qRt2n4OG9ZimlcHYYOtgAHwfmzYivmAyk33TcZld4YNyTeZMEDhS8D4WAsdCwTmU+xg5NPgKjojTRF6vBhdowd7b/WDYQC8T1FNV/v223Y9l/uUhtlNZDq83pxpSOn3+13OXf//5LRCZTDx9Tyoqu7zKxDUIRKVJPPhVFUGat+LRbA5Xfe3Q0ALLjHZfNVkGfQo31mOLzFWpN+7VqxD0oO7yQNTAQbumwEJYQdrhPSr2dmnA98r70o8eXUH0QCQRznXQ7BJ2E9hM3fOrY+ucg0+jWUHR986LXdFUeKZn0doC0O/NZnaxyAIaZdTE00brp62+v5RoxAoGBAP0lWGO23D7eEFc176oMec8llB3annZ7N9j7DiLm2QORLZJ+zuV2dfigX20SdW3ZFqu9YlW9u5i2sc0b7AlT7mcSShpFMUyLJjfQKdvRRECF8wVoDFk/aONR8WRrz4fW3RU0bFgiaZ5PgoB1G0E+/NVn392NuIdsoJ0ha8Uqhcz1AoGBAORPahfJdEjE6F9uH/b4oV9bYZG/A5Z2vuwRx5offg0xbw6u+leXjnsax13dX1j11eqWAgg1/phuUxHzbv5jzysLqzj/XqfeaKXobM6gdQ7hldzpynn3gKuJjShlle6N0xr33u6lHsMU0FINMzLgWuLf15o/5m88eNhp1V0uFKKHAoGAPY4XMCgG5kKZNpum63KdLAG3QosmfSj5K4ngphv8KSHkMvsi1Ck6Bnr4uU0DwPJI0Pn8L10zgK7sDTP88Ue3cNjBrCGnGzW61VeI1irMrePkdCwY1JrWpnAGgqS0khNtLvrQXZ4AkL5EvXe8aOEoGbxoczdC56tCYvL9gbQVVQECgYBFXDL5AwTGzrthso0XdLVhyNs9cfBfF7gs88HV+tdKnsgEh/gaADsS/zGuPICpABZ67BO19uFf4bRu8au4sQ3RH/xmln5lNVZJgPD9XRXy7Wmf8Y7Huv9mHaW6rhH8pS2LNd6OVa+gyIP5SXVScYJrBmHzxJH3HUIBTTW61zMBpQKBgQCNhNdDUY8OXec3vP/IjlWW0n1TN1faZ2wz6C+lxxHej01HmIbaRvz28ILDUjvB5UeCk/SPdDfdvpRA2bl/Ou2DO4594nFH433fqsK/mudsxzXyIj1nUjL0pWUdc/SiywzHcMtDC9/Qdu7pCmdMIDKU8wTUzgDSYn9n/mjbLwcxrQ==-----END RSA PRIVATE KEY-----

[root@gosec2 LIVE02 ~]# 
```
