import QtQuick

Rectangle {
    id: help
    color: "darkslategray"
    height: 300

    Column {
        id: keyList
        anchors.leftMargin: 50
        anchors.topMargin: 10
        anchors.left: parent.left
        anchors.top: parent.top
        width: 250
        spacing: 4

        Text { text: "Echap (esc)........................................................."; width: parent.width; elide: Text.ElideRight; color: "white"; font.pixelSize: 18 }
        Text { text: "P..................................................................."; width: parent.width; elide: Text.ElideRight; color: "white"; font.pixelSize: 18 }
        Text { text: "Touche +............................................................"; width: parent.width; elide: Text.ElideRight; color: "white"; font.pixelSize: 18 }
        Text { text: "Touche -............................................................"; width: parent.width; elide: Text.ElideRight; color: "white"; font.pixelSize: 18 }
        Text { text: "Flèche Haut........................................................."; width: parent.width; elide: Text.ElideRight; color: "white"; font.pixelSize: 18 }
        Text { text: "Flèche Bas.........................................................."; width: parent.width; elide: Text.ElideRight; color: "white"; font.pixelSize: 18 }
        Text { text: "Flèche Gauche......................................................."; width: parent.width; elide: Text.ElideRight; color: "white"; font.pixelSize: 18 }
        Text { text: "Flèche Droite......................................................."; width: parent.width; elide: Text.ElideRight; color: "white"; font.pixelSize: 18 }
        Text { text: "Autre touche........................................................"; width: parent.width; elide: Text.ElideRight; color: "white"; font.pixelSize: 18 }

    }

    Column {

        anchors.topMargin: 10
        anchors.left: keyList.right
        anchors.right: parent.right
        anchors.top: parent.top
        spacing: 4

        Text { text: "Quitter l'application"; color: "yellow"; font.pixelSize: 18 }
        Text { text: "Plein écran"; color: "yellow"; font.pixelSize: 18 }
        Text { text: "Accélérer défilement"; color: "yellow"; font.pixelSize: 18 }
        Text { text: "Ralentir défilement"; color: "yellow"; font.pixelSize: 18 }
        Text { text: "Réduire hauteur de ligne"; color: "yellow"; font.pixelSize: 18 }
        Text { text: "Augmenter hauteur de ligne"; color: "yellow"; font.pixelSize: 18 }
        Text { text: "Réduire taille de police"; color: "yellow"; font.pixelSize: 18 }
        Text { text: "Augmenter taille de police"; color: "yellow"; font.pixelSize: 18 }
        Text { text: "Afficher /cacher ce panneau"; color: "yellow"; font.pixelSize: 18 }

    }

}

