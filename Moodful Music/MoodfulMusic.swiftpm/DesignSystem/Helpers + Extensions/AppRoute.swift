import SwiftUI

enum AppRoute: Hashable, Equatable {
    case mood
    case environment(mood: String)
    case load(finalSentence: String)
    case music(moodTrack: String, ambienceTrack: String)
    case onboardingStep
}
