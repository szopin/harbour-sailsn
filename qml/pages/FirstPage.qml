import QtQuick 2.2
import Sailfish.Silica 1.0
import QtQuick.XmlListModel 2.0

 Page {
    id: firstPage
        allowedOrientations: Orientation.All


    SilicaListView {
        id:list
        ViewPlaceholder {
            id: vplaceholder
            enabled: feedModel.status != XmlListModel.Ready
            text: "Loading..."
            ProgressBar {
                anchors.top: vplaceholder.bottom
                width: parent.width
                value: feedModel.progress

            }
        }

       header: PageHeader {
                title: "SoylentNews"
                }
        anchors.top: header.bottom
        width: parent.width
        height: parent.height    
        PullDownMenu {
            MenuItem {
                text: "About"
                onClicked: pageStack.push("about.qml");
            }
            MenuItem {
                text: "Reload"
            onClicked: feedModel.reload();
            }
        }

        VerticalScrollDecorator {}
        model: XmlListModel {

            id: feedModel
            source: "http://www.soylentnews.org/index.rss"
            namespaceDeclarations: "declare namespace rdf='http://www.w3.org/1999/02/22-rdf-syntax-ns#'; declare default element namespace 'http://purl.org/rss/1.0/';"
             query: "/rdf:RDF/item"

            XmlRole { name: "title"; query: "title/string()" }
            XmlRole { name: "link"; query: "link/string()" }
            XmlRole { name: "description"; query: "description/string()" }
            }

          delegate: Item {
            width: parent.width
            height: Theme.itemSizeMedium
            visible: feedModel.status == XmlListModel.Ready
            anchors  {

                left: parent.left
                right: parent.right
                margins: Theme.paddingSmall
                }

            Label {
                id:  theTitle
                text: title
                wrapMode: Text.Wrap
                font.pixelSize: Theme.fontSizeSmall
                anchors {
                    left: parent.left
                    right: parent.right
                    }
                }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    var name = list.model.get(index).name
                        pageStack.push("SecondPage.qml", {"content": description, "url": link, "snTitle": title });

                    }
                }
            }
        }
   }

