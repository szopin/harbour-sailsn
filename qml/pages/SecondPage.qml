import QtQuick 2.2
import Sailfish.Silica 1.0

Page {
    id: secondpage
    allowedOrientations: Orientation.All
    property string content
    property string url
    property string snTitle

    SilicaFlickable {
        contentHeight: column.height
        anchors.fill: parent
        PageHeader {
            id: pageHeader
                title: snTitle
                }
        VerticalScrollDecorator {}
        PullDownMenu {
            MenuItem {
                text: "Open in browser"
                onClicked: Qt.openUrlExternally(url)
                }
            MenuItem {
                text: "Open in webview"
                onClicked: pageStack.push("webview.qml", {"pageurl": url });

            }
        }
    Column {
        width: parent.width
        anchors.top: pageHeader.bottom
            id: column
            Label {
                text: content
                font.pixelSize: Theme.fontSizeSmall
                linkColor: Theme.highlightColor
                wrapMode: Text.Wrap
                anchors {
                            left: parent.left
                            right: parent.right
                            margins: Theme.paddingLarge
                }
            }
        }
    }

}

