import SwiftUI
struct CircleButtonVibrant: ButtonStyle {
    enum Buttonsize {
        case small, large
    }
    
    let size: Buttonsize
    let buttonIcon: Image?
    
    init(size: Buttonsize, buttonIcon: Image? = nil) {
        self.size = size
        self.buttonIcon = buttonIcon
    }
    
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            Circle()
                .fill(size == .small ? .white.opacity(0.2) : .white.opacity(0.5))
                .frame(width: size == .small ? 64 : 90,
                       height: size == .small ? 64 : 90)
                .overlay(
                    size == .small
                    ? Circle().stroke(.white.opacity(0.2), lineWidth: 2)
                    : nil
                )
                .opacity(configuration.isPressed ? 0.7 : 1.0)
            
            if let icon = buttonIcon {
                icon
                    .resizable()
                    .scaledToFit()
                    .frame(width: size == .small ? 33 : 36,
                           height: size == .small ? 34 : 55)
                    .foregroundStyle(.white)
            } else {
                configuration.label
            }
        }
    }
}
