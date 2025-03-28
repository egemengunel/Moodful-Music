import SwiftUI

struct MoodCards:View {
    let model: MoodCard
    
    var body: some View {
        VStack(spacing: 14) {
            Text(model.emoji)
                .font(.system(size: 100))
            
            Text(model.moodName)
                .typography(.body2, weight: .regular)
                .foregroundStyle(.black)
        }
        .padding()
        .frame(width: 240, height:233)
        .background(RoundedRectangle(cornerRadius: 30).fill(Color.white))
    }
}
