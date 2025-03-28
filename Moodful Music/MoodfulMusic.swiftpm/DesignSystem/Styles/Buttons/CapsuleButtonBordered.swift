import SwiftUI

struct CapsuleButtonBordered: ButtonStyle {
    let buttonIcon: Image?
    
    init(buttonIcon: Image?) {
        self.buttonIcon = buttonIcon
    }
    
    func makeBody(configuration: Configuration) -> some View {
        HStack(spacing: 8) {
            if let icon = buttonIcon {
                icon
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
                .foregroundStyle(AppColors.accent2)
                .typography(.body5, weight: .bold)
            }
            
            configuration.label
                .typography(.body4, weight: .bold)
                .foregroundStyle(AppColors.accent2)
        }
            .padding(.horizontal, 32)
            .frame(height: 52)
            .background(Capsule().stroke(AppColors.accent2))
            .opacity(configuration.isPressed ? 0.7: 1.0)
    }
}
