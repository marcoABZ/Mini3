//
//  Profile.swift
//  Mini3
//
//  Created by Pablo Penas on 19/11/21.
//

import Foundation
import SwiftUI

    
enum Game: String, CaseIterable {
    case quebraCabeca = "Quebra-Cabeça"
    case formas = "Formas"
    case sonsEimagens = "Sons e Imagens"
    case palheta = "Palheta de cores"
    case imagensEformas = "Imagens e formas"
    
    func isAvailable() -> Bool {
        if self == .quebraCabeca {
            return true
        }
        
        return false
    }
    
    func getCoverImage(mascote: Mascotes) -> String {
        var aux = ""
        switch self {
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
                return "coelhoMini\(aux)Cover"
            case .chiba:
                return "chibaMini\(aux)Cover"
            case .gato:
                return "gatoMini\(aux)Cover"
        }
    }
    
    func getDescription() -> String {
        switch self {
        case .quebraCabeca:
            return "Organize e monte a imagem."
        default:
            return "Jogo em desenvolvimento"
        }
    }
    
}
