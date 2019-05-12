import QtQuick 2.3
import QtQuick.Layouts 1.2
import QtQuick.Controls 2.0

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

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton
        onClicked: {
            if (mouse.button === Qt.LeftButton)
                contextMenu.popup()
        }
        onPressAndHold: {
            if (mouse.source === Qt.MouseEventNotSynthesized)
                contextMenu.popup()
        }

        Menu {
            id: contextMenu
            MenuItem {
                text: "Disable..."
                onTriggered: {
                    request(plasmoid.configuration.apiurl+"?disable&auth="+plasmoid.configuration.pwhash, callback)
                }
            }
            MenuItem {
                text: "Enable..."
                onTriggered: {
                    request(plasmoid.configuration.apiurl+"?enable&auth="+plasmoid.configuration.pwhash, callback)
                }
            }
        }
    }

    function callback(x){
        if (x.readyState === 4) {
            if (x.status === 200){
                try{
                    var w = JSON.parse(x.responseText);
                    if (w.status ==='disabled'){
                        blocked.color= "#505050";
                        tot.color= "#505050"
                    }
                    if (w.status ==='enabled')
                    {
                        blocked.color= "#fd4b39";
                        tot.color= "#00a65a"
                    }
                    try{
                        tot.value = w.dns_queries_today;
                        blocked.value = w.ads_blocked_today;
                        blocked.smallValue = "("+w.ads_percentage_today+"%)";
                    }
                    catch(err){}
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
