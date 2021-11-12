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
    @Published var image: UIImage = UIImage(named: "placeholder")!
    @Published var hd: Int = 3
    @Published var vd: Int = 1
    @Published var or: Bool = false
    
    init(teste: Bool) {
        addConfig(MemoryGameConfiguration(verticalDivision: 1, som: true, animacao: true, ordenacao: false), forGame: .quebraCabeca)
    }
    
    func addConfig(_ config: Configuration, forGame game: Game) {
        configs[game] = config
    }
}

struct MemoryGameConfiguration: Configuration {
    
    var verticalDivision: Int = 1
    var horizontalDivision: Int = 3
    var som: Bool = false
    var animacao: Bool = false
    var ordenacao: Bool = false
    var tipoOrdenacao: Int = 0
    var image: UIImage = UIImage(named: "placeholder")!
    
    init(verticalDivision: Int = 1, horizontalDivision: Int = 3, som: Bool = false, animacao: Bool = false, ordenacao: Bool = false, tipoOrdenacao: Int = 0, image: UIImage = UIImage(named: "placeholder")!) {
        self.verticalDivision = verticalDivision
        self.horizontalDivision = horizontalDivision
        self.som = som
        self.animacao = animacao
        self.ordenacao = ordenacao
        self.tipoOrdenacao = tipoOrdenacao
        self.image = image
    }
    
    mutating func setImage(_ im: UIImage) {
        image = im
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

