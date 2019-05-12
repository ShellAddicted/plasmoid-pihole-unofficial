import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 2.0 as PlasmaComponents
import org.kde.plasma.extras 2.0 as PlasmaExtras


ColumnLayout {
    property alias cfg_interval: interval.value
    property alias cfg_apiurl: apiurl.text
    property alias cfg_pwhash: pwhash.text

    ColumnLayout{
        spacing: 5
        Layout.alignment: Qt.AlignTop
        ColumnLayout{
            Label{
                text: i18n("Interval")
            }

            RowLayout{
                SpinBox {
                    id: interval
                    minimumValue: 0.5          
                    maximumValue: 99999
                }
                Label{
                    text: i18n("seconds")
                }

            }

        }

        ColumnLayout{
            Label{
                text: i18n("pihole Api URL: (Example: http://pi.hole/admin/api.php)")
            }

            TextField {
                id: apiurl
                Layout.fillWidth: true
            }

            Label{
                text: i18n("pihole Api authentifcation token: (value of WEBPASSWORD in /etc/pihole/setupVars.conf)")
            }

            TextField {
                id: pwhash
                Layout.fillWidth: true
            }

        }
    }
    


}
