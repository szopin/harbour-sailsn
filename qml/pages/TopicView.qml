import QtQuick 2.2
import Sailfish.Silica 1.0

 Page {
    id: topicPage
        allowedOrientations: Orientation.All
        property string source: "https://soylentnews.org/api.pl?m=story&op=latest&limit=50&tid="
        property string tid
        property string topic: "1"
        property string textname
        property string pagetitle: textname == "" ? "SoylentNews" : "SoylentNews - " + textname
        property string combined: tid == "" ? source + topic : source + tid
        onCombinedChanged: {
            var xhr = new XMLHttpRequest;
            xhr.open("GET", combined);
            xhr.onreadystatechange = function() {
                if (xhr.readyState === XMLHttpRequest.DONE) {
                    var data = JSON.parse(xhr.responseText);
                    model.clear();

                    for (var i=0;i<50;i++) {
                        model.append({title: data[i]["title"], intro: data[i]["introtext"], description: data[i]["bodytext"], link: "https://soylentnews.org/article.pl?sid=" + data[i]["sid"]});
                    }
                }
            }
            xhr.send();
        }

    SilicaListView {
        id:list
        ViewPlaceholder {
            id: vplaceholder
            enabled: model.count == 0
            text: "Loading..."

        }

       header: PageHeader {
                title: pagetitle
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
                text: "Browse by topic"
                onClicked: pageStack.push("TopicSelect.qml");

            }
        }

        VerticalScrollDecorator {}
        model: ListModel { id: model}

        Component.onCompleted: {
            var xhr = new XMLHttpRequest;
            xhr.open("GET", combined);
            xhr.onreadystatechange = function() {
                if (xhr.readyState === XMLHttpRequest.DONE) {
                    var data = JSON.parse(xhr.responseText);
                    model.clear();

                    for (var i=0;i<50;i++) {
                        model.append({title: data[i]["title"], intro: data[i]["introtext"], description: data[i]["bodytext"], link: "https://soylentnews.org/article.pl?sid=" + data[i]["sid"]});
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
                        pageStack.push("SecondPage.qml", {"content": description, "intro": intro, "url": link, "snTitle": title });

                    }
                }
            }
        }
   }

