//
//  GameCoverModel.swift
//  Mini3
//
//  Created by Pablo Penas on 10/11/21.
//

import Foundation
import SwiftUI

struct GameCoverModel {
    let imageName: String
    let title: String
    let description: String
    
    init(imageName: String, title: String, description: String) {
        self.imageName = imageName
        self.title = title
        self.description = description
    }
}
