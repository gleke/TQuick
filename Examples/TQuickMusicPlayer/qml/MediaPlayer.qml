import QtQuick 2.6
import TQuick 1.2
import QtMultimedia 5.6


MediaPlayer {
    id: qmediaplayer
    function mplay(url) {
        source = url
        play()
    }
}



