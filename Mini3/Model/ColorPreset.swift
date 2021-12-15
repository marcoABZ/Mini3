//
//  ColorPreset.swift
//  Mini3
//
//  Created by Marco Zulian on 14/12/21.
//

import Foundation
import SwiftUI

@objc enum ColorPreset: Int16, CaseIterable {
    case purple
    case blue
    case green
    case yellow
    case red
    case pink
    
    func getColor() -> Color {
        switch self {
        case .purple: return Color.init(red: 123/255, green: 86/255, blue: 202/255)
        case .blue: return Color.init(red: 94/255, green: 196/255, blue: 214/255)
        case .green: return Color.init(red: 91/255, green: 142/255, blue: 90/255)
        case .yellow: return Color.init(red: 231/255, green: 170/255, blue: 66/255)
        case .red: return Color.init(red: 236/255, green: 109/255, blue: 92/255)
        case .pink: return Color.init(red: 222/255, green: 127/255, blue: 178/255)
        }
    }
}
