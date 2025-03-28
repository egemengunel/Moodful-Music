import SwiftUI

struct MoodCarouselView: View {    
    @Binding var selectedIndex: Int
    let moodCardsData: [MoodCard]
    
    var body: some View {
        GeometryReader { outerGeo in
            VStack {
                Spacer()
                ScrollViewReader {scrollProxy in
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 32) {
                            ForEach(moodCardsData.indices, id: \.self) { index in
                                GeometryReader { cardGeo in
                                    MoodCards(model: moodCardsData[index])
                                        .opacity(
                                            index == selectedIndex ? 1.0 : 0.3
                                        )
                                        .id(index)
                                        .background(
                                            Color.clear.preference(
                                                key: CardCenterPreferenceKey.self,
                                                value: [index: cardGeo.frame(in: .global).midX]
                                            )
                                        )
                                }
                                .frame(width: 250, height: 300)
                            }
                        }
                        .padding(.horizontal, (outerGeo.size.width - 120) / 2)
                        
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                            selectedIndex = 3
                            scrollProxy.scrollTo(3, anchor: .center)
                        }
                        }
                        .onPreferenceChange(CardCenterPreferenceKey.self) { centers in
                            let screenCenterX = outerGeo.frame(in: .global).midX
                            let newIndex = MoodCarouselHelper.updatedSelectedIndex(from: centers, screenCenterX: screenCenterX, currentSelectedIndex: selectedIndex)
                            if newIndex != selectedIndex {
                                DispatchQueue.main.async {
                                    selectedIndex = newIndex
             
                                }
                            }
                        }
                    }
                }
                Spacer()
            }
        }
    }
}
