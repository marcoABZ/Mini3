//
//  Profile.swift
//  Mini3
//
//  Created by Pablo Penas on 19/11/21.
//

import Foundation
import SwiftUI

enum Game: Int {
    case quebraCabeca = 1
    case formas
    case somImagens
    case palheta
    case imagemFormas
    
    func isAvailable() -> Bool {
        if self == .quebraCabeca {
            return true
        }
        
        return false
    }
}
