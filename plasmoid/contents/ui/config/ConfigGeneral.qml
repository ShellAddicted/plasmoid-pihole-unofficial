import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 2.0 as PlasmaComponents
import org.kde.plasma.extras 2.0 as PlasmaExtras

import "../../code/utils.js" as Utils;


Item {
    property alias cfg_interval: interval.value
    property alias cfg_apiurl: apiurl.text
    property string cfg_passwordhash: ""

    ColumnLayout {
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
                    text: i18n("PiHole Api URL: (Example: http://pi.hole/admin/api.php)")
                }

                TextField {
                    id: apiurl
                    Layout.fillWidth: true
                }
            }

            ColumnLayout{
                Label{
                    text: i18n("PiHole password:")
                }

                TextField {
                    id: pwd
                    property var pwdhash: {
                        Utils.getDoubleSha256asHex(pwd.text)
                    }
                    onPwdhashChanged:{
                        cfg_passwordhash = pwd.pwdhash
                    }
                    echoMode: TextInput.Password
                    Layout.fillWidth: true
                }
            }
        }
    }
}