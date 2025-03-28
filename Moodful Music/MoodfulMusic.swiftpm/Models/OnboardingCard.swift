import SwiftUI

struct OnboardingCard: Identifiable {
    let id = UUID()
    let icon: Image
    let title: String
    let description: String
}

// Provide a custom conformance:
extension OnboardingCard: Hashable {
    static func == (lhs: OnboardingCard, rhs: OnboardingCard) -> Bool {
        lhs.id == rhs.id &&
        lhs.title == rhs.title &&
        lhs.description == rhs.description
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(title)
        hasher.combine(description)
    }
}
