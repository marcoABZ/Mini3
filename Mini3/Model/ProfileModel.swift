//
//  ProfileModel.swift
//  Mini3
//
//  Created by Pablo Penas on 11/11/21.
//

import Foundation
import SwiftUI

struct ProfileModel: Equatable {
    var name: String
    var birthdate: Date
    var selectedColor: Color
    var darkModeEnabled: Bool
    //TODO: Interesses
    
    var image: Image
    
    init(name: String, birthdate: Date, color: Color, image: String, darkModeEnabled: Bool = false) {
        self.name = name
        self.birthdate = birthdate
        self.selectedColor = color
        self.image = Image(image)
        self.darkModeEnabled = darkModeEnabled
    }
}
