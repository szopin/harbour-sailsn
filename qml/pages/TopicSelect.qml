import QtQuick 2.2
import Sailfish.Silica 1.0

 Page {
    id: topicSelectPage
        allowedOrientations: Orientation.All


    SilicaListView {
        id:list
        ViewPlaceholder {
            id: vplaceholder
            enabled: model.count == 0
            text: "Loading..."

        }

       header: PageHeader {
                title: "Topics"
                }
        anchors.top: header.bottom
        width: parent.width
        height: parent.height

        VerticalScrollDecorator {}
        model: ListModel { id: model}

        Component.onCompleted: {
            var xhr = new XMLHttpRequest;
            xhr.open("GET", "https://soylentnews.org/api.pl?m=story&op=topiclist");
            xhr.onreadystatechange = function() {
                if (xhr.readyState === XMLHttpRequest.DONE) {
                    var data = JSON.parse(xhr.responseText);
                    model.clear();

                    for (var i=0;i<data.length;i++) {
                        if (data[i]["searchable"] === "yes"){
                          model.append({textname: data[i]["textname"], topic: data[i]["tid"]});
                    }
                    }
                }
            }
            xhr.send();
        }


          delegate: Item {
            width: parent.width
            height: Theme.itemSizeMedium

            anchors  {

                left: parent.left
                right: parent.right
                margins: Theme.paddingSmall
                }

            Label {
                id:  theTitle
                text: textname
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
                        pageStack.replaceAbove(null, "TopicView.qml", {"tid": topic, "textname": textname});

                    }
                }
            }
        }
   }

