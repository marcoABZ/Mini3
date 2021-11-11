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

struct MemoryGameConfiguration: Configuration {
    
    @State var verticalDivision: Int = 1
    @State var horizontalDivision: Int = 3
    @State var som: Bool = false
    @State var animacao: Bool = false
    @State var ordenacao: Bool = false
    @State var tipoOrdenacao: Int = 0
    
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

//protocol Configuration {
//    var title: String { get }
//    var subtitle: String? { get }
//}
protocol Configuration {}

struct ConfiguracaoFolha: Configuration {
    let title: String
    let subtitle: String?
    let selectorType: SelectorType
}

struct ConfiguracaoPai: Configuration {
    let title: String
    let subtitle: String?
    let children: [Configuration]
}

enum SelectorType: CaseIterable {
    case toggle
    case plusMinus
    case wheel
    
}

