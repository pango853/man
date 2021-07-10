

# Browser Console

```controlling-the-browser.js

var newTabBrowser = gBrowser.getBrowserForTab(gBrowser.selectedTab);
newTabBrowser.addEventListener("load", function() {
  newTabBrowser.contentDocument.body.innerHTML = "<h1>this page has been eaten</h1>";
}, true);
newTabBrowser.contentDocument.location.href = "https://mozilla.org/";

```

```modifying-the-browser
var parent = window.document.getElementById("appmenuPrimaryPane");
var makeTheTea = gBrowser.ownerDocument.defaultView.document.createElementNS("http://www.mozilla.org/keymaster/gatekeeper/there.is.only.xul", "menuitem");
makeTheTea.setAttribute("label", "A nice cup of tea?");
parent.appendChild(makeTheTea);

var parent = window.document.getElementById("menu_ToolsPopup");
var makeTheTea = gBrowser.ownerDocument.defaultView.document.createElementNS("http://www.mozilla.org/keymaster/gatekeeper/there.is.only.xul", "menuitem");
makeTheTea.setAttribute("label", "A nice cup of tea?");
parent.appendChild(makeTheTea);
```


https://play.grafana.org/


https://play.grafana.org/d/000000063/prometheus-templating?orgId=1
https://play.grafana.org/d/5eue-XDGz/datasource-variable?orgId=1


function(t) {
  var r = t.shiftKey || t.ctrlKey || t.metaKey;
  n.handleEvent(t), n.props.onToggle(e, r)
}

https://play.grafana.org/d/000000063/prometheus-templating?orgId=1&var-instance=demo.robustperception.io:9100


