import SwiftUI


struct OnboardingStepView: View {
    
    @State var viewModel: OnboardingViewModel
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                Image("Gradient")
                    .resizable()
                    .scaledToFill()
                    .frame(width: proxy.size.width, height: proxy.size.height)
                    .ignoresSafeArea()
                
                ZStack{
                    RoundedRectangle(cornerRadius: 40)
                        .frame(width: 1082, height: 550)
                        .opacity(0.25)
                    Group{
                        switch viewModel.currentState {
                        case .selectYourMood:
                            textBody(viewModel.selectYourMoodCard)
                        case .customizeYourTune:
                            textBody(viewModel.customizeYourTune)
                        case .enjoyThePerfectTrack:
                            textBody(viewModel.enjoyThePerfectTrack)
                        }
                    }
                }
                .id(viewModel.currentState)
                .transition(
                    .push(from: .trailing)
                )
                
                continueButton
            }
        }
        .frame(minWidth: 1210, minHeight: 834)
    }
}

extension OnboardingStepView {
    
    func textBody(_ card: OnboardingCard) -> some View {
        VStack (spacing: 32){
            HStack{ 
                card.icon
                    .typography(.heading1, weight: .bold)
                
                Text(card.title)
                    .typography(.heading1, weight: .bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .foregroundStyle(.white)

            Text(card.description)
                .multilineTextAlignment(.leading)
                .typography(.body1, weight: .medium)
                .foregroundStyle(.white)
        }
        .frame(width: 1032)
    }
    
    
    var continueButton: some View {
        HStack{
            Spacer()
            Button {
                viewModel.nextStep()
            } label: {
                switch viewModel.currentState {
                case .selectYourMood:
                    Text("Continue")
                case .customizeYourTune:
                    Text("Continue")
                case .enjoyThePerfectTrack:
                    Text("Let’s Start")
                }
            }
            .buttonStyle(
                CapsuleButtonFilled(
                    buttonIcon: viewModel.currentState != .enjoyThePerfectTrack ? Image.Icon.forwardIcon : nil
                )
            )
        }
        .padding(.trailing, 64)
        .padding(.bottom, 64)
        .frame(maxHeight: .infinity, alignment: .bottomTrailing)
    }
}

