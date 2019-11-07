import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: aboutPage

    Flickable {
        id: flickable
        anchors.fill: parent

        PageHeader {
            id: header;
            title: "About"
        }

        Rectangle {
            anchors {
                left: parent.left;
                right: parent.right;
                top: header.bottom
            }
            height: parent.height
            color: "transparent"

            
            
            Label {
                id: appName
                text: "SailSN"
                anchors.horizontalCenter: parent.horizontalCenter
                font.family: Theme.fontFamily
                font.pixelSize: Theme.fontSizeLarge
            }

            Text {
                id: desc
                anchors {
                    top: appName.bottom;
                    left: parent.left;
                    right: parent.right;
                    margins: Theme.paddingMedium
                }
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: Theme.fontSizeExtraSmall
                color: Theme.primaryColor
                wrapMode: Text.Wrap
                text: "SoylentNews browser for Sailfish OS v1.1\nBy szopin\nLicensed under MIT";
            }
            
            Button {
                id: github
                anchors {
                    top: desc.bottom;
                    horizontalCenter: parent.horizontalCenter;
                    margins: Theme.paddingMedium
                }
                text: "Github"
                onClicked: Qt.openUrlExternally("https://github.com/szopin/harbour-sailsn");
            }                                  
                        Button {
                id: license
                anchors {
                    top: github.bottom;
                    horizontalCenter: parent.horizontalCenter;
                    margins: Theme.paddingLarge
                }
                text: "License"
                onClicked: Qt.openUrlExternally("https://github.com/szopin/harbour-sailsn/blob/master/LICENSE");
            }                                  
        }
    }
}
