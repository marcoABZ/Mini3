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
    
//    TODO: Linkar a cor com o perfil
    let selectedColor: Color
    
    let gamesAvailable = [
        GameCoverModel(imageName: "coverExample", title: "Alfabetização", description: "Forme palavras e sílabas."),
        GameCoverModel(imageName: "coverExample", title: "Quebra-cabeça", description: "Organize e monte a imagem."),
        GameCoverModel(imageName: "coverExample", title: "Formas", description: "Esse jogo utiliza formas.")
    ]
    
    init() {
        self.profileListShowing = true
        self.pickerSelection = .games
        self.selectedColor = .purple
    }

}
