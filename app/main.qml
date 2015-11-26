import QtQuick 2.3
import QtQuick.Window 2.2

Window {
    id: window
    visible: true
    height: 1200
    width: 1600
    flags: Qt.Dialog

    property string inactiveColor: "black"
    property string fontColor: "black"
    property string inactiveFontColor: "white"

    property int index: 0

    Item {
        id: rootItem
        anchors.centerIn: parent
        width: parent.height
        height: parent.width
        rotation: 90

        Keys.onPressed: {
            if (event.key === Qt.Key_Home) {
                if (window.index === 0) {
                    window.index = 2
                } else {
                    window.index = 0
                }
                event.accepted = true
                return
            } else if (event.key === Qt.Key_PowerOff) {
                console.log("Poweroff requested")
                event.accepted = true
                return
            }

            console.log("Key pressed: " + event.key)
        }

        Rectangle {
            id: topBar
            height: 60
            anchors {
                top: parent.top
                left: parent.left
                right: parent.right
            }
            color: "black"

            Row {
                anchors.fill: parent
                spacing: 1

                Rectangle {
                    id: homebutton
                    width: 100
                    height: parent.height
                    color: "white"
                    Text {
                        anchors.fill: parent
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        color: "black"
                        text: "XO"
                        font.family: "Helvetica"
                    }
                    Rectangle {
                        anchors {
                            bottom: parent.bottom
                            left: parent.left
                            right: parent.right
                        }
                        height: 10
                        color: window.index === 0 ? "white" : "black"
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            window.index = 0
                        }
                    }
                }

                Repeater {
                    id: tabRepeater
                    model: ["ARCHIVE", "NOTES", "SKETCH", "DOCUMENT"]
                    Rectangle {
                        width: 200
                        height: parent.height
                        Text {
                            id: text
                            anchors.fill: parent
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                            color: "black"
                            text: modelData
                        }
                        Rectangle {
                            anchors {
                                bottom: parent.bottom
                                left: parent.left
                                right: parent.right
                            }
                            height: 10
                            color: window.index === index + 1 ? "white" : "black"
                        }
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                window.index = index + 1
                            }
                        }
                    }
                }
            }
        }

        MainScreen {
            id: mainScreen
            visible: (window.index === 0)
            anchors {
                top: topBar.bottom
                right: parent.right
                left: parent.left
                bottom: parent.bottom
            }

            onNewNoteClicked: {
                window.index = 2
            }

            onNewSketchClicked: {
                window.index = 3
            }

            onArchiveClicked: {
                if (archiveIndex === -1) {
                    window.index = 1
                    return
                }

                if (archiveIndex < 3) {
                    window.index = archiveIndex + 1
                }
            }
        }

        ArchiveView {
            id: archiveView
            visible: (window.index === 1)
            anchors {
                top: topBar.bottom
                right: parent.right
                left: parent.left
                bottom: parent.bottom
            }
        }


        NoteTab {
            id: noteArea
            visible: window.index === 2
            anchors {
                top: topBar.bottom
                right: parent.right
                left: parent.left
                bottom: parent.bottom
            }
        }


        SketchTab {
            id: sketchArea
            visible: window.index === 3
            anchors {
                top: topBar.bottom
                right: parent.right
                left: parent.left
                bottom: parent.bottom
            }
        }

        DocumentTab {
            visible: window.index === 4
            anchors {
                top: topBar.bottom
                right: parent.right
                left: parent.left
                bottom: parent.bottom
            }

            pageModel: [
                "file:///data/pdf/1.png",
                "file:///data/pdf/2.png",
                "file:///data/pdf/3.png",
                "file:///data/pdf/4.png",
                "file:///data/pdf/5.png"
            ]
        }
    }
}
