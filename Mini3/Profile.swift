//
//  Profile.swift
//  Mini3
//
//  Created by Marco Zulian on 08/11/21.
//

import SwiftUI

class Profile: ObservableObject {
    
    @Published var color: Color = .blue
    @Published var configs: [Game: Configuration] = [:]
    
    init(teste: Bool) {
        addConfig(MemoryGameConfiguration(verticalDivision: 7, som: true, animacao: false, ordenacao: true), forGame: .quebraCabeca)
    }
    
    func addConfig(_ config: Configuration, forGame game: Game) {
        configs[game] = config
    }
}

class MemoryGameConfiguration: Configuration {
    
    var verticalDivision: Int = 1
    var horizontalDivision: Int = 3
    var som: Bool = false
    var animacao: Bool = false
    var ordenacao: Bool = false
    var tipoOrdenacao: Int = 0
    
    init(verticalDivision: Int = 1, horizontalDivision: Int = 3, som: Bool = false, animacao: Bool = false, ordenacao: Bool = false, tipoOrdenacao: Int = 0) {
        self.verticalDivision = verticalDivision
        self.horizontalDivision = horizontalDivision
        self.som = som
        self.animacao = animacao
        self.ordenacao = ordenacao
        self.tipoOrdenacao = tipoOrdenacao
    }
}

enum Game {
    case quebraCabeca
}

protocol Configuration {}
