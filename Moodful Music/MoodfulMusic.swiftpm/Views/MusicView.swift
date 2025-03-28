import SwiftUI

struct MusicView: View {    
    @State var viewModel: MusicViewModel
     @State private var isPlaying = false
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                // 1) Background
                Image("Gradient")
                    .resizable()
                    .scaledToFill()
                    .frame(width: proxy.size.width, height: proxy.size.height)
                    .clipped()
                VStack{      
                    if viewModel.showThankYouMessage{
                        Text("Thank you for trying out this project! Made by Egemen Günel.")
                            .typography(.heading5, weight: .light)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                            .transition(.opacity)
                            .frame(width: 740, height: 200, alignment: .center)
                    } else {
                        Text(viewModel.titleForMood())
                            .typography(.heading4, weight: .light)
                            .foregroundColor(.white)
                    }
                }
            }
            .overlay(
                Button {
                    viewModel.stopMusic()
                    viewModel.coordinator.popTo(.mood)
                } label: {
                    Text("Start Again")
                }
                    .buttonStyle(CapsuleButtonVibrant(buttonIcon: Image.Icon.restartIcon))
                    .padding(.top, 64)
                    .padding(.trailing, 64),
                    alignment: .topTrailing
            )
            .overlay(
                Group {
                    if !viewModel.showThankYouMessage {
                        HStack(spacing: 34) {
                            Button(action: {
                                viewModel.skipBackward5s()
                            }) {
                                // button content
                            }
                            .buttonStyle(CircleButtonVibrant(size: .small, buttonIcon: Image.Icon.fiveSecBckIcon))
                            
                            Button(action: {
                                if isPlaying {
                                    viewModel.pauseMusic()
                                } else {
                                    viewModel.resumeMusic()
                                }
                                isPlaying.toggle()
                            }) {
                                // button content
                            }
                            .buttonStyle(CircleButtonVibrant(size: .large, buttonIcon: isPlaying ? Image.Icon.pauseIcon : Image.Icon.playIcon))
                            
                            Button(action: {
                                viewModel.skipForward5s()
                            }) {
                                // button content
                            }
                            .buttonStyle(CircleButtonVibrant(size: .small, buttonIcon: Image.Icon.fiveSecFwdIcon))
                        }
                        .padding(.bottom, 64)
                        .transition(.opacity)
                    }
                }
                .animation(.easeIn(duration: 1), value: viewModel.showThankYouMessage),
                alignment: .bottom
            )
        }
        .onAppear {
            viewModel.startMusic()
            isPlaying = true
        }
        .onDisappear {
            viewModel.stopMusic()
        }
    }
}
