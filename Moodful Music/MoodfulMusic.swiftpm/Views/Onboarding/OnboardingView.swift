import SwiftUI

struct OnboardingView: View {
    
    @State var viewModel: OnboardingViewModel
    
    var body: some View{
        GeometryReader { proxy in
            ZStack {
                Image("Gradient")
                    .resizable()
                    .scaledToFill()
                    .frame(width: proxy.size.width, height: proxy.size.height)
                    .ignoresSafeArea()
                
                // 2) Foreground content
                VStack{
                    Spacer().frame(height: 240) // Top spacing
                    VStack{  
                        Text("Welcome To Moodful Music")
                            .typography(.heading2, weight: .bold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom, 64)
                            .padding(.horizontal, 95)
                            .foregroundStyle(.white)
                        
                        // 3) Cards in an HStack
                        HStack(spacing: 94) {
                            ForEach(
                                OnboardingViewModel.State.allCases
                            ) { state in
                                switch state {
                                case .selectYourMood:
                                    OnboardingCards(model: viewModel.selectYourMoodCard)
                                case .customizeYourTune:
                                    OnboardingCards(model: viewModel.customizeYourTune)
                                case .enjoyThePerfectTrack:
                                    OnboardingCards(model: viewModel.enjoyThePerfectTrack)
                                }
                            }
                        }
                    }
                    
                    Spacer()
                    
                    HStack {
                        Spacer()
                        Button {
                            withAnimation { 
                                viewModel.coordinator.navigate(to: .onboardingStep)
                            }
                        } label: {
                            Text("Get Started")
                        }
                        .buttonStyle(CapsuleButtonFilled())
                        .padding(.trailing, 64)
                        .padding(.bottom, 64)
                    }
                }
            }
        }
        .frame(minWidth: 1210, minHeight: 834)
    }
}

