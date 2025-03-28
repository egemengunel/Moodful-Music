import SwiftUI

struct LoadingView: View{
    @ObservedObject var viewModel: LoadingViewModel
    @State private var isAnimating = false
    @State var frame: CGSize = .init(width: 256, height: 256)
    @State var isTransition: Bool = false 
    @State private var loadingTask: Task<Void, Never>? = nil
    @Namespace var transition
    
    var body: some View{
        ZStack {
            
            if isTransition {
                Image("Gradient")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: frame.width, height: frame.height)
                    .matchedGeometryEffect(id: "loading", in: transition)
            } else {
                Image("Gradient")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: frame.width, height: frame.height)
                    .clipShape(Circle())
                    .scaleEffect(isAnimating ? 1.2 : 1.0)
                    .animation(.easeInOut(duration: 0.8).repeatForever(), value: isAnimating)
                    .matchedGeometryEffect(id: "loading", in: transition)
            }
            
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            Color(uiColor: .systemGroupedBackground)
        }
        .overlay(alignment: .bottomLeading, content: { 
            HStack {
                Button(action: {
                    loadingTask?.cancel()
                    viewModel.coordinator.popTo(.mood)
                }) {
                    Text("Cancel")
                }
                .buttonStyle(CapsuleButtonBordered(buttonIcon: nil))
                
                Spacer()
            }
            .padding(.horizontal, 64)
            .padding(.bottom, 64)
        })
        .onAppear {
            // Start the animation
            withAnimation {
                isAnimating = true
            }
            
            // Create and store the Task
            loadingTask = Task {
                viewModel.prepareMusic()
                
                try? await Task.sleep(nanoseconds: 4_000_000_000)
                guard !Task.isCancelled else { return }
                
                withAnimation {
                    isAnimating = false
                    isTransition = true
                    frame = CGSize(
                        width: UIScreen.main.bounds.width,
                        height: UIScreen.main.bounds.height
                    )
                }
                
                viewModel.coordinator.navigate(
                    to: .music(
                        moodTrack: viewModel.moodFile,
                        ambienceTrack: viewModel.ambienceFile
                    )
                )
            }
        }
        .onDisappear {
            loadingTask?.cancel()
        }
    }
}
