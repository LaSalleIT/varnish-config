# varnish-config
Varnish configuration for CDN testing

##Typical usage
  We're using a three-layer approach, consisting of a reverse-proxy, a caching server, and the actual server which hosts the content.

```
+---------------------------------------------------+
| Nginx (under different domain name per-request)   |
+---------------------------------------------------+
                        |
                        |
                        |
                        |
+---------------------------------------------------+
| Varnish (Handles caching,request header=lschs.org)|
+---------------------------------------------------+
                        |
                        |
                        |
                        |
+---------------------------------------------------+
|      www.lschs.org/lschs.org/lasalle.finalsite.com|
+---------------------------------------------------+
```
