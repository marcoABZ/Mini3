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
    @Published var isSidebarOpen: Bool = false
    @Published var hasSidebar: Bool = true
    
    //Forçar update do picker
    @Published var renderView: Bool = false
    
    init() {
        self.profileListShowing = true
        self.pickerSelection = .games
    }
    
    @Published var covers: [GameCoverModel] = []
    
    func getGamesAvailable(mascote: Mascotes) {
        covers = [
            GameCoverModel(game:.quebraCabeca, image: getCoverImage(game: .quebraCabeca, mascote: mascote), title: "Quebra-cabeça", description: "Organize e monte a imagem."),
            GameCoverModel(game:.formas, image: getCoverImage(game: .formas, mascote: mascote), title: "Formas e cores", description: "Jogo em desenvolvimento"),
            GameCoverModel(game:.sonsEimagens, image: getCoverImage(game: .sonsEimagens, mascote: mascote), title: "Som e imagem", description: "Jogo em desenvolvimento"),
            GameCoverModel(game:.palheta, image: getCoverImage(game: .palheta, mascote: mascote), title: "Palheta de cores", description: "Jogo em desenvolvimento"),
            GameCoverModel(game:.imagensEformas, image: getCoverImage(game: .imagensEformas, mascote: mascote), title: "Imagens e formas", description: "Jogo em desenvolvimento")
            ]
    }
    
    func getCoverImage(game: Game, mascote: Mascotes) -> Image {
        var aux = ""
        switch game {
        case .quebraCabeca:
            aux = "1"
        case .formas:
            aux = "2"
        case .sonsEimagens:
            aux = "3"
        case .palheta:
            aux = "4"
        case .imagensEformas:
            aux = "5"
        }
        switch mascote {
            case .coelho:
                return Image("coelhoMini\(aux)Cover")
            case .chiba:
                return Image("chibaMini\(aux)Cover")
            case .gato:
                return Image("gatoMini\(aux)Cover")
        }
    }
}
