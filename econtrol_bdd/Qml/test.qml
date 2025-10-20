import QtQuick 2.15
import QtQuick.Controls 2.5
import QtQuick.Window 2.2

Window{
        visible: true
        width: 400
        height: 420
        title:qsTr("Formulaire")

       /* Column{
            anchors.centerIn: parent
            spacing:20
            Text {
                id:mytitle
                text:qsTr("Formulaire")
                font.pixelSize: 20
                anchors.horizontalCenter: parent.horizontalCenter
            }

            TextField {
                id: myfield
               placeholderText: "Entrer votre nom"
                width: parent.width *0.8
            }



       ComboBox{
        id:mycombo
        width: parent.width * 0.8
        model:ListModel{
            ListElement{Text:"Masculin"}
            ListElement{Text:"Féminin"}
        }
         }
       Button{
           id:mybtn
           text:"Enregistrer"
           anchors.horizontalCenter:parent.horizontalCenter
           onClicked: backend.requete(myfield.text)
       }
}*/
}
