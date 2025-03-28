import SwiftUI

struct MoodView: View{
    @State var viewModel: MoodViewModel
     @State private var selectedIndex: Int = 3
    
    private let moodCardsData: [MoodCard] = [
        .init(emoji: "🗻", moodName: "Adventurous"),
        .init(emoji: "😌", moodName: "Calm"),
        .init(emoji: "😢", moodName: "Sad"),
        .init(emoji: "⚡️", moodName: "Energetic"),
        .init(emoji: "😊", moodName: "Joyful"),
        .init(emoji: "🌟", moodName: "Reflective"),
        .init(emoji: "🌧", moodName: "Melancholic"),
        .init(emoji: "🧙", moodName: "Mystical")
    ]
    
    var body: some View {
        ZStack{
            Color(uiColor: .systemGroupedBackground)
                .ignoresSafeArea()
            
            VStack(spacing: 24){
                
                Text("How Are You Feeling Today?")
                    .typography(.heading1, weight: .bold)
                    .multilineTextAlignment(.center)
                
              MoodCarouselView(selectedIndex: $selectedIndex, moodCardsData: moodCardsData)
                
                HStack{
                    Spacer()
                    
                    Button(action: {
                        let selectedMood = moodCardsData[selectedIndex]
                        print("User selected mood: \(selectedMood.moodName)")
                   viewModel.coordinator.navigate(to: .environment(mood: selectedMood.moodName))

                        
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
