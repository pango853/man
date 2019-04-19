
# Command-line options
https://developer.mozilla.org/en-US/docs/Mozilla/Command_Line_Options#-private

-private
-private-window URL


# Tuning
Browse to about:config in Firefox
Click on "I'll be carefull, I promise!"

Search signon.autologin.proxy and network.websocket.enabled in the Search Input Box then change their values as follow:

signon.autologin.proxy=true
network.websocket.enabled=false



Proxy password problem in Mozilla Firefox 3 - SOLVED by accident :)

    Start Firefox 3
    In Address bar write "about:config"
    In filter write network.auth.use-sspi
    Double click on "true" and it should become "false"
    If things does not become better write here to give other changes I made. So far nothing else worked until this change

Try it. It might solve your problem. Credits to Revell


network.negotiate-auth.allow-proxies : false network.proxy.share_proxy_settings  : false network.automatic-ntlm-auth.allow-proxies : false network.auth.use : false signon.autologin.proxy : true 


I figured out the solution by myself. The address of proxy was unfortunately added to list of sites for which passwords are not remembered. After removing the proxy address from this list, I am able to save username and password using Password manager. 


Double-click network.negotiate-auth.allow-proxies to toggle between true and false. The option must be set to false. (It seems counterintuitive, but you set it to false to make it work with the ISA proxy.)


