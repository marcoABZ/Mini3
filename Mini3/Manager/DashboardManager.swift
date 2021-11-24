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
            GameCoverModel(game:.somImagens, image: getCoverImage(game: .somImagens, mascote: mascote), title: "Som e imagem", description: "Jogo em desenvolvimento"),
            GameCoverModel(game:.palheta, image: getCoverImage(game: .palheta, mascote: mascote), title: "Palheta de cores", description: "Jogo em desenvolvimento"),
            GameCoverModel(game:.imagemFormas, image: getCoverImage(game: .imagemFormas, mascote: mascote), title: "Imagens e formas", description: "Jogo em desenvolvimento")
            ]
    }
    
    func getCoverImage(game: Game, mascote: Mascotes) -> Image {
        switch mascote {
            case .coelho:
                return Image("coelhoMini\(game.rawValue)Cover")
            case .chiba:
                return Image("chibaMini\(game.rawValue)Cover")
            case .gato:
                return Image("gatoMini\(game.rawValue)Cover")
        }
    }
}
