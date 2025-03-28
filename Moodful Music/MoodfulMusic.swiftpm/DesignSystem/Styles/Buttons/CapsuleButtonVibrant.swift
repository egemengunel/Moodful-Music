import SwiftUI
struct CapsuleButtonVibrant: ButtonStyle {
    let buttonIcon: Image?
    
    init(buttonIcon: Image? = nil) {
        self.buttonIcon = buttonIcon
    }
    
    func makeBody(configuration: Configuration) -> some View {
        HStack(spacing: 8) {
            if let icon = buttonIcon {
                icon
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .typography(.body5, weight: .bold)
                    .foregroundStyle(.white)
            }
            
            configuration.label
                .typography(.body4, weight: .bold)
                .foregroundStyle(.white)
        }
            .padding(.horizontal, 32)
            .frame(height: 52)
            .background(Capsule().fill(.white.opacity(0.25)))
            .overlay(Capsule().stroke(.white.opacity(0.20), lineWidth: 2))
            .opacity(configuration.isPressed ? 0.7: 1.0)
    }
}
