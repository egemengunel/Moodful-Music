import SwiftUI

struct Typography {
    enum Style {
        case heading1, heading2, heading3, heading4, heading5
        case body1, body2, body3, body4, body5
        
        var size: CGFloat {
            switch self {
            case .heading1: return 78
            case .heading2: return 64
            case .heading3: return 64
            case .heading4: return 64
            case .heading5: return 48
                
            case .body1: return 36
            case .body2: return 36
            case .body3: return 30
            case .body4: return 24
            case .body5: return 22
            }
        }
    }
}

extension View {
    func typography(_ style: Typography.Style, weight: Font.Weight = .regular) -> some View {
        self.font(.system(size: style.size, weight: weight, design: .rounded))
    }
}
