//
//  Profile.swift
//  Mini3
//
//  Created by Marco Zulian on 08/11/21.
//

import SwiftUI

class Profile: ObservableObject {
    
    @Published var color: Color = .orange
    @Published var configs: [Game: Configuration] = [:]
    
    init(teste: Bool) {
        addConfig(PuzzleConfiguration(verticalDivision: 1, som: true, animacao: true, ordenacao: false), forGame: .quebraCabeca)
    }
    
    func addConfig(_ config: Configuration, forGame game: Game) {
        configs[game] = config
    }
}


enum Game {
    case quebraCabeca
}

protocol Configuration {}

