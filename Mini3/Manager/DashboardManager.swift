//
//  DashboardManager.swift
//  Mini3
//
//  Created by Pablo Penas on 10/11/21.
//

import Foundation
import SwiftUI

enum ViewModes: String, CaseIterable {
    case games = "Jogos"
    case performance = "Desempenho"
}

class DashboardManager: ObservableObject {
    
    @Published var profileListShowing: Bool
    @Published var pickerSelection: ViewModes
    
    //Forçar update do picker
    @Published var renderView: Bool = false
    
    init() {
        self.profileListShowing = true
        self.pickerSelection = .games
    }
    
    @Published var covers: [GameCoverModel] = []
    
    func getGamesAvailable(mascote: Mascotes) {
        covers = [
                GameCoverModel(image: getCoverImage(game: .quebraCabeca, mascote: mascote), title: "Alfabetização", description: "Forme palavras e sílabas."),
                GameCoverModel(image: getCoverImage(game: .formas, mascote: mascote), title: "Quebra-cabeça", description: "Organize e monte a imagem."),
            ]
    }
    
    func getCoverImage(game: Game, mascote: Mascotes) -> Image {
        switch game {
        case .quebraCabeca:
            switch mascote {
            case .coelho:
                return Image("coelhoMini1Cover")
            case .chiba:
                return Image("chibaMini1Cover")
            case .gato:
                return Image("gatoMini1Cover")
            }
        case .formas:
            switch mascote {
            case .coelho:
                return Image("coelhoMini2Cover")
            case .chiba:
                return Image("chibaMini2Cover")
            case .gato:
                return Image("gatoMini2Cover")
            }
        }
    }
}