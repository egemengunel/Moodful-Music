import SwiftUI

@Observable
class EnvironmentViewModel {
    //navigation
    var coordinator: NavigationCoordinator
    var mood: String
    
    init(coordinator: NavigationCoordinator, mood:String){
        self.coordinator = coordinator 
        self.mood  = mood
    }
}

