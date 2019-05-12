import QtQuick 2.3
import QtQuick.Layouts 1.2


Rectangle{
    id: blockroot
    property string labelText: ""
    property string value: ""
    property string smallValue: ""
    property string logo: ""
    FontLoader {
        id: ft;
        source:'../fonts/SourceSansPro-Semibold.ttf'
    }



    RowLayout{
        anchors.fill: parent;
        id: clay
        ColumnLayout {
            spacing: -5
            Text {
                color: "#ffffff"
                text: blockroot.labelText
                font.family: ft.name
                font.pixelSize: clay.height/3
                Layout.alignment: Qt.AlignTop
            }
            RowLayout{
                Layout.alignment: Qt.AlignBottom
                Text {
                    color: "#ffffff"
                    text: blockroot.value
                    font.family: ft.name
                    font.pixelSize: clay.height/2
                }

                Text{
                    color: "#ffffff"
                    text: blockroot.smallValue
                    font.family: ft.name
                    font.pixelSize: clay.height/2.85
                    Layout.alignment: Qt.AlignBottom | Qt.AlignRight
                    
                }
            }



        }

        Image {
            Layout.preferredWidth: 64
            Layout.fillHeight: true
            Layout.alignment: Qt.AlignBottom | Qt.AlignRight
            fillMode: Image.PreserveAspectFit
            source: blockroot.logo
        } 



    }
    Layout.minimumHeight: 50
    Layout.minimumWidth: clay.Layout.minimumWidth;
    Layout.fillWidth: true
    Layout.fillHeight: true
}
