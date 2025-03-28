import SwiftUI

struct CardCenterPreferenceKey: PreferenceKey {
    static var defaultValue: [Int: CGFloat] = [:]
    
    static func reduce(value: inout [Int: CGFloat], nextValue: () -> [Int: CGFloat]) {
        value.merge(nextValue(), uniquingKeysWith: { $1 })
    }
}

struct MoodCarouselHelper {
    static func opacity(for index: Int, selectedIndex: Int) -> Double {
        let offset = abs(index - selectedIndex)
        switch offset {
        case 0:
            return 1.0
        case 1:
            return 0.3
        case 2:
            return 0.2
        default:
            return 0.1
        }
    }
    
    static func updatedSelectedIndex(from centers: [Int: CGFloat], screenCenterX: CGFloat, currentSelectedIndex: Int) -> Int {
        if let closest = centers.min(by: { abs($0.value - screenCenterX) < abs($1.value - screenCenterX) }) {
            return closest.key
        }
        return currentSelectedIndex
    }
}
