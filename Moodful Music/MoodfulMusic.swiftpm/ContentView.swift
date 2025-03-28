import SwiftUI

struct ContentView: View {
    
    @State var coordinator = NavigationCoordinator()
    @Namespace var zoomTransition
    
    var body: some View {
        NavigationStack(path: $coordinator.path){
            OnboardingView(viewModel: .init(coordinator: coordinator))
                .toolbarVisibility(.hidden, for: .navigationBar)
                .navigationTransition(.zoom(sourceID: "zoom", in: zoomTransition))
                .navigationDestination(for: AppRoute.self) { route in
                    switch route {
                    case .mood:
                        MoodView(viewModel: .init(coordinator: coordinator))
                            .toolbarVisibility(.hidden, for: .navigationBar)
                        
                        
                    case .environment(let moodString):
                        EnvironmentView(
                            viewModel: EnvironmentViewModel(
                                coordinator: coordinator,
                                mood: moodString
                            )
                        )
                        .toolbarVisibility(.hidden, for: .navigationBar)
                        
                        
                    case .load(let finalSentence):
                        LoadingView(
                            viewModel: .init(
                                coordinator: coordinator,
                                finalSentence: finalSentence
                            )
                        )
                        .toolbarVisibility(.hidden, for: .navigationBar)
                        
                        
                    case .music(let moodTrack, let ambienceTrack):
                        MusicView(
                            viewModel: MusicViewModel(
                                coordinator: coordinator,
                                moodTrack: moodTrack,
                                ambienceTrack: ambienceTrack
                            )
                        )
                        .toolbarVisibility(.hidden, for: .navigationBar)
                        
                        
                    case .onboardingStep:
                        OnboardingStepView(viewModel: .init(coordinator: coordinator))
                        .toolbarVisibility(.hidden, for: .navigationBar)
                        .navigationTransition(.zoom(sourceID: "zoom", in: zoomTransition))
                    }
                    
                }
            
        }
       
    }
}
