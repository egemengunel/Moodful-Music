import SwiftUI

@Observable
class OnboardingViewModel{
    var coordinator: NavigationCoordinator
    
    let selectYourMoodCard: OnboardingCard = .init(
        icon: Image.Icon.moodIcon,  
        title: "Select Your Mood",
        description: "Your mood selection defines the core of your custom track. Select an option that best represents how you feel whether it’s energetic, calm, melancholic, or uplifting. Moodful Music uses CreateML’s text classification to analyze your choice for personalized listening experience, ensuring that the generated track resonates with your emotions."
    )
    
    let customizeYourTune: OnboardingCard = .init(
        icon: Image.Icon.environmentIcon, 
        title: "Select An Environment",
        description: "Choose the environment that defines the background ambience. Options like 'jungles', 'mountains', 'deserts', or 'garden' directly influence the spatial sound effects layered with your track. This selection is critical for contextualizing your listening experience."
    )
    
    let enjoyThePerfectTrack: OnboardingCard = .init(
        icon:Image.Icon.appIcon,
        title: "Enjoy The Perfect Track",
        description: "Moodful Music uses CreateML’s text classification to process your mood and environment selections. Using CoreML, it dynamically merges instrumentals with ambient elements, generating a fully customized audio track tailored to your inputs. The result is a  composition that aligns with your selections."
    )
    
    var currentState: State = .selectYourMood
    
    enum State: CaseIterable, Identifiable {
        case selectYourMood
        case customizeYourTune
        case enjoyThePerfectTrack
        
        var id: Self { self }
    }
    
    
    init(coordinator: NavigationCoordinator) {
        self.coordinator = coordinator 
    } 
    
    func nextStep() {
        withAnimation {
            switch currentState {
            case .selectYourMood:
                currentState = .customizeYourTune
            case .customizeYourTune:
                currentState = .enjoyThePerfectTrack
            case .enjoyThePerfectTrack:
                coordinator.navigate(to: .mood)
            }
        }
    }
    
}
