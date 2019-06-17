import QtQuick 2.3
import QtQuick.Layouts 1.2
import QtQuick.Dialogs 1.0

import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 2.0 as PlasmaComponents
import QtQuick.Controls.Styles.Plasma 2.0 as Styles

import "../code/utils.js" as Utils;

Item{
    property var summary_data
    property var togglePiHoleStatus: Utils.togglePiHoleStatus

    Plasmoid.preferredRepresentation: Plasmoid.compactRepresentation
    Plasmoid.compactRepresentation: CompactRepr {}
    Plasmoid.fullRepresentation: FullRepr {}

    Timer {
        id: textTimer
        interval: plasmoid.configuration.interval*1000;
        repeat: true
        running: true
        triggeredOnStart: true
        onTriggered: Utils.performHttpGET(plasmoid.configuration.apiurl+"?summary", Utils.handle_api_response)
    }
}

