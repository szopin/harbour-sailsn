import QtQuick 2.2
import Sailfish.Silica 1.0

Page {
    id: secondpage
    allowedOrientations: Orientation.All
    property string content
    property string intro
    property string url
    property string snTitle
    property int commentcount
    property string discussion

    SilicaFlickable {
        contentHeight: column.height + pageHeader.height
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
            MenuItem {
                text: "Comments (" + commentcount + ")"
                visible: commentcount > 0
                onClicked: pageStack.push("CommentView.qml", {"discussion": discussion, "snTitle": snTitle });

            }
        }
    Column {
        width: parent.width
        anchors.top: pageHeader.bottom
            id: column
            Label {
                text: content == intro ? content : intro + content
                font.pixelSize: Theme.fontSizeSmall
                linkColor: Theme.highlightColor
                onLinkActivated: {
                    var dialog = pageStack.push("OpenLinkDialog.qml", {link: link});
                }
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

