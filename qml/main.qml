import QtQuick
import QtQuick.Window
import QtQuick.Dialogs
import QtCore

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
        currentFolder: StandardPaths.standardLocations(StandardPaths.HomeLocation)[0]

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
            console.log("Home dir"+StandardPaths.standardLocations(StandardPaths.HomeLocation)[0])
        }

    }

    // @disable-check M16
    onClosing: (close) => {
        console.log("You want to close the main window !!!!!!!!!!!!")
        close.accepted = false
        controller.quit()
    }


}

