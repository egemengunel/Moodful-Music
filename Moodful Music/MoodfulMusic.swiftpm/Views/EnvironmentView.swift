import SwiftUI

struct EnvironmentView: View {
    @State var viewModel: EnvironmentViewModel
    
    @State private var selectedIndex: Int = 3
    
    private let environmentCardsData: [MoodCard] = [
        .init(emoji: "🐒", moodName: "Jungles"),
        .init(emoji: "🏔", moodName: "Mountains"),
        .init(emoji: "🏜", moodName: "Deserts"),
        .init(emoji: "🌷", moodName: "Garden"),
        .init(emoji: "🏞", moodName: "Lake"),
        .init(emoji: "🌧", moodName: "Rain"),
        .init(emoji: "🏟", moodName: "Stadium"),
        .init(emoji: "🌆", moodName: "City Streets")
    ]
    
    var body: some View {
        ZStack {
            Color(uiColor: .systemGroupedBackground)
                .ignoresSafeArea()
            
            VStack(spacing: 24) {
                Text("Select Your Environment")
                    .typography(.heading1, weight: .bold)
                    .multilineTextAlignment(.center)
                
                MoodCarouselView(selectedIndex: $selectedIndex, moodCardsData: environmentCardsData)
                
                HStack {
                    Button(action: {
                        viewModel.coordinator.pop()
                    }) {
                        Text("Back")
                    }
                    .buttonStyle(CapsuleButtonBordered(buttonIcon: Image.Icon.backIcon))
                    
                    
                    Spacer()
                 
                    Button(action: {
                        let selectedEnv = environmentCardsData[selectedIndex]
                        let environmentName = selectedEnv.moodName
                        
                    
                        let finalSentence = "I am feeling \(viewModel.mood) in the \(environmentName)."
                        
                        print("Final Sentence: \(finalSentence)")
                        viewModel.coordinator.navigate(
                            to: .load(finalSentence: finalSentence)
                        )
                    }) {
                        Text("Continue")
                    }
                    .buttonStyle(CapsuleButtonOutline(buttonIcon: Image.Icon.forwardIcon))
                }
                .padding(.horizontal, 64)
                .padding(.bottom, 64)
            }
            .padding(.top, 146)
        }
    }
}
