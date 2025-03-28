import SwiftUI

struct CapsuleButtonFilled: ButtonStyle {
    let buttonIcon: Image?
    
    init(buttonIcon: Image? = nil) {
        self.buttonIcon = buttonIcon
    }
    
    func makeBody(configuration: Configuration) -> some View {
        HStack(spacing: 8) {
            configuration.label
                .typography(.body4, weight: .bold)
                .foregroundStyle(AppColors.accent2)
            
            if let icon = buttonIcon {
                icon
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24) 
                .foregroundStyle(AppColors.accent2)
                .typography(.body5, weight: .bold)
        }
        }           
            .padding(.horizontal, 32)
            .frame(height: 52)
            .background(Capsule().fill(.white))
            .opacity(configuration.isPressed ? 0.7: 1.0)
    }
}
