import SwiftUI

@Observable
final class NavigationCoordinator {
    
    // Properties
    var path: [AppRoute] = []
    
    // Methods
    func navigate(to route: AppRoute) {
        path.append(route)
    }
    
    func pop() {
        path.removeLast()
    }
    
    func reset() {
        path.removeLast(path.count)
    }
    
}
extension NavigationCoordinator {
    func popTo(_ target: AppRoute) {
        guard let index = path.firstIndex(of: target) else { return }
        let stepsToRemove = path.count - index - 1
        withAnimation {
            path.removeLast(stepsToRemove)
        }
    }
}
