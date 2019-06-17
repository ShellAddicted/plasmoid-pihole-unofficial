
import QtQuick 2.3
import QtQuick.Layouts 1.2
import QtQuick.Controls 2.0

ColumnLayout{
    Block {
        labelText: i18n("Total Queries")
        color: "#00a65a"
        logo: '../images/server.png'
        value: summary_data.ERR !== undefined ? summary_data.ERR : summary_data.dns_queries_today
        smallValue: summary_data.ERR !== undefined ? "" : (summary_data.status === "enabled" ? i18n("Enabled") : i18n("Disabled"))
    }

    Block {
        labelText: i18n("Blocked Queries")
        color: "#fd4b39"
        logo: '../images/closed.png'
        value: summary_data.ads_blocked_today
        smallValue: summary_data.ads_percentage_today === undefined ? "" : "("+summary_data.ads_percentage_today+"%)"
    }

    Block {
        labelText: i18n("Unique Domains")
        color: "#fd4b39"
        value: summary_data.unique_domains
    }

    Block {
        labelText: i18n("Unique Clients")
        color: "#fd4b39"
        value: summary_data.unique_clients
    }

    Button {
      Layout.alignment: Qt.AlignHCenter
      text: summary_data.status === "enabled" ? i18n("Disable") : i18n("Enable") + (plasmoid.configuration.passwordhash === "" ? "("+i18n("Set Password in settings")+")" : "")
      onClicked: togglePiHoleStatus()
    }

}
