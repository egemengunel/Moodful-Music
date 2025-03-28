import SwiftUI

struct OnboardingCards: View {
    let model: OnboardingCard
    
    var body: some View{
        VStack(spacing:12){
            model.icon
                .resizable()
                .scaledToFit()
                .frame(width: 233, height: 148)
                .foregroundColor(.white)
            
            Text(model.title)
                .typography(.body1, weight: .medium)
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
        }
        .padding()
        .frame(width: 297, height: 310)
        .background(RoundedRectangle(cornerRadius: 40).fill(Color.white.opacity(0.25)))
    }
}
