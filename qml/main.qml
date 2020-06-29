import QtQuick 2.4
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.0

Window {
    id: rootWindow
    visible: true
    color: "black"
    width: 800
    height: 600

    AppView {
        id: appView
    }

    FileDialog {
        id: fileDialog
        title: "Sélectionnez un fichier"
        folder: shortcuts.home

        property string filename: ""

        onAccepted: {
            filename = fileDialog.fileUrls[0]
            listModel.setAdvertFile(filename);
            //appView.focus = true
            close()
        }
        onRejected: {
            print("Canceled")
            //appView.focus = true
            close()
        }
        Component.onCompleted: {
            width = rootWindow.width
            height = rootWindow.height
        }

    }

    onClosing: {
        close.accepted = false
        controller.quit()

    }

}

