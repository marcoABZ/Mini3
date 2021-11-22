//
//  Profile.swift
//  Mini3
//
//  Created by Pablo Penas on 19/11/21.
//

import Foundation
import SwiftUI

class Profile: ObservableObject {
    
    @Published var color: Color = .orange
    @Published var configs: [Game: Configuration] = [:]
    
    
    init(teste: Bool) {
        addConfig(PuzzleConfiguration(verticalDivision: 1, som: true, ordenacao: .none), forGame: .quebraCabeca)
    }
    
    func addConfig(_ config: Configuration, forGame game: Game) {
        configs[game] = config
    }
}


enum Game {
    case quebraCabeca
    case formas
}

protocol Configuration {}
