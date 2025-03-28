import SwiftUI

@Observable
class MoodViewModel {
    //navigation
    var coordinator: NavigationCoordinator
    
    init(coordinator: NavigationCoordinator) {
        self.coordinator = coordinator 
    }
}
