import QtQuick 2.3
import QtQuick.Layouts 1.2


ColumnLayout{

    Block {
        id:tot
        labelText: i18n("Total Queries")
        color: "#00a65a"
        logo: '../images/server.png'
    }

    Block {
        id: blocked
        labelText: i18n("Blocked Queries")
        color: "#fd4b39"
        logo: '../images/closed.png'
    }

    function callback(x){
        if (x.readyState == 4) {
            if (x.status == 200){
                try{
                    var w = JSON.parse(x.responseText);
                    tot.value = w.dns_queries_today;
                    blocked.value = w.ads_blocked_today;
                    blocked.smallValue = "("+w.ads_percentage_today+"%)";
                }
                catch(err){
                    tot.value = i18n("JSON Error");
                    blocked.value = i18n("Check your settings");
                    blocked.smallValue = "";
                }
            }
            else{
                tot.value = i18n("Error");
                blocked.value = i18n("Check Network");
                blocked.smallValue = "";
            }
        }
    }
    
    function request(url, callback) {
        var xhr = new XMLHttpRequest();
        xhr.timeout = 1000;
        xhr.onreadystatechange = (function f() {callback(xhr)});
        xhr.open('GET', url, true);
        xhr.send();
    }

    Timer {
        id: textTimer
        interval: plasmoid.configuration.interval*1000;
        repeat: true
        running: true
        triggeredOnStart: true
        onTriggered: request(plasmoid.configuration.apiurl+"?summary", callback)
    }
}
