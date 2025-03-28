import SwiftUI

extension Image{
    enum Icon {
        static let backIcon = Image(systemName: "arrow.backward")
        static let forwardIcon = Image(systemName: "arrow.forward")
        static let historyIcon = Image(systemName:"clock.arrow.trianglehead.counterclockwise.rotate.90")
        static let playIcon = Image(systemName: "play")
        static let pauseIcon = Image(systemName: "pause")
        static let restartIcon = Image(systemName: "arrow.counterclockwise")
        static let fiveSecBckIcon = Image(systemName: "5.arrow.trianglehead.counterclockwise")
        static let fiveSecFwdIcon = Image(systemName: "5.arrow.trianglehead.clockwise")
        
        //Onboardig Icons
        static let moodIcon = Image(systemName: "theatermasks")
        static let environmentIcon = Image(systemName: "mountain.2")
        static let appIcon = Image(systemName: "apple.haptics.and.music.note")
    }
}
