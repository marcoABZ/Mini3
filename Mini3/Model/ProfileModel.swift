//
//  ProfileModel.swift
//  Mini3
//
//  Created by Pablo Penas on 11/11/21.
//

import Foundation
import SwiftUI

enum Mascotes: CaseIterable {
    case coelho
    case chiba
    case gato
    
    static func getImageIconName(animal: Mascotes) -> String {
        switch animal {
        case .coelho:
            return "coelhoSquare"
        case .chiba:
            return "chibaSquare"
        case .gato:
            return "gatoSquare"
        }
    }
    
    static func getCardCoverImages(animal: Mascotes, jogo: Game) -> String {
        switch animal {
        case .coelho:
            return "coelhoRegistroCover\(jogo)"
        case .chiba:
            return "chibaRegistroCover\(jogo)"
        case .gato:
            return "gatoRegistroCover\(jogo)"
        }
    }
}

struct ProfileModel: Equatable, Hashable, Identifiable {
    var name: String
    var birthdate: Date
    var selectedColor: Color
    var darkModeEnabled: Bool
    var mascote: Mascotes
    var id = UUID()
    var image: Image
    
    init(name: String, birthdate: Date, color: Color, image: String, darkModeEnabled: Bool = false) {
        self.name = name
        self.birthdate = birthdate
        self.selectedColor = color
        self.image = Image(image)
        self.darkModeEnabled = darkModeEnabled
        self.mascote = .coelho
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
