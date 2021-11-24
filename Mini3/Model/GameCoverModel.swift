//
//  GameCoverModel.swift
//  Mini3
//
//  Created by Pablo Penas on 10/11/21.
//

import Foundation
import SwiftUI

struct GameCoverModel {
    let game: Game
    let image: Image
    let title: String
    let description: String
    
    init(game: Game, image: Image, title: String, description: String) {
        self.game = game
        self.image = image
        self.title = title
        self.description = description
    }
}
