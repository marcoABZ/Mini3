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
}
