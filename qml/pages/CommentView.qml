import QtQuick 2.2
import Sailfish.Silica 1.0

Page {
    id: commentpage
    allowedOrientations: Orientation.All
    property string content
    property string source: "https://soylentnews.org/api.pl?m=comment&op=discussion&sid="
    property string intro
    property int commentcount
    property string url
    property string snTitle
    property string discussion


         function getcomments(){
            var xhr = new XMLHttpRequest;
            xhr.open("GET", source + discussion);
            xhr.onreadystatechange = function() {
                if (xhr.readyState === XMLHttpRequest.DONE) {
                    var data = JSON.parse(xhr.responseText);
                    list.model.clear();

                    getkids(data, 0, 0);

                }
            }
            xhr.send();
    }

    function getkids(data, cid, indent){

     var kids1 = data[cid].kids

      for (var j=0;j<kids1.length;j++) {
               list.model.append({subject: data[kids1[j]]["subject"], nickname: data[kids1[j]]["nickname"], comment: data[kids1[j]]["comment"], pid: data[kids1[j]]["pid"], indent: indent, cid: data[kids1[j]]["cid"]});
            if (data[kids1[j]]["kids"] !== 0) {

                getkids(data, data[kids1[j]]["cid"], indent + 1);
            }
        }
    }




    SilicaListView {
        id: list
        header: PageHeader {
            title: snTitle
            id: pageHeader
        }
        width: parent.width
        height: parent.height
        anchors.top: header.bottom
        VerticalScrollDecorator {}

        ViewPlaceholder {
            id: vplaceholder
            enabled: commodel.count == 0
            text: "Loading..."
            }

        model: ListModel { id: commodel}
          delegate: Item {
            width: list.width
            height: cid.height

            anchors  {
                left: parent.left
                right: parent.right

                }
              Repeater {
                model: indent
                   Rectangle {

                    color: index % 2 ? "orange" : "blue"
                    anchors {
                        top: parent.top
                        left: parent.left
                        leftMargin:  Theme.paddingMedium * index
                        bottom: parent.bottom
                        }
                    width: 1
                    }
                }
            Label {
                id:  cid
                text: " <b>" + nickname + "</b><p><i>" + subject + "</i></p>\n" + comment
                textFormat: Text.RichText
                wrapMode: Text.Wrap
                font.pixelSize: Theme.fontSizeSmall
                anchors {
                    leftMargin: Theme.paddingMedium * indent
                    rightMargin: Theme.paddingSmall
                    left: parent.left
                    right: parent.right
                    }
                onLinkActivated: {
                    var dialog = pageStack.push("OpenLinkDialog.qml", {link: link});
                }
                }
            }
        Component.onCompleted: commentpage.getcomments();
    }
}


