##############################################################################################################
#                                                                                                            #
# +___+         /--------+         /---------    +-+       +-+    /--------+                                 #
# |   |       / /--------+        | /------'     | |_______| |   / /-------+                                 #
# |   |___    \_________  \       | |_______     | +-------+ |   \________|  \                            gg #
# |_______|    ___________/       \_________|    |_|       |_|   |__________/     (DOT)     ?/=\  /==  gggg  #
#           - V a r n i s h    C o n f i g u r a t i o n -                                 | \o/  -/   g  gg #
#           @author    Alex Fang                                                                  ||   \\ggg #
#           @type      Varnish middleware configuration                                                  ggg #
#           @date      05/26/2016                                                                      gggg  #
#                                                                                                            #
##############################################################################################################

backend default {
    .host = "lasalle.finalsite.com";  # Finalsite hosting address
    .port = "80";
    .probe = {
        .url = "/";
        .timeout = 72ms; #New York to San Antonio
        .interval = 1s;
        .window = 10;
        .threshold = 8;
    }
}

sub vcl_recv {
   # Do not cache admin path
   if (req.http.host ~ "example.com" ||
        req.url ~ "^/cf_admin" ||
        req.http.Cookie ~ "logged_in" ||
        req.request == "POST") {
        return (pass);
    }

    # No cookies
    unset req.http.Cookie;

    # Grace Time one hour
    set req.grace = 1h;
}

sub vcl_fetch {
    # Set the TTL for cache object to five minutes
    set beresp.ttl = 5m;

    # Set Grace Time to one hour
    set beresp.grace = 1h;
}
