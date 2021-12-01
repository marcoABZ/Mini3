//
//  SelectedProfileManager.swift
//  Mini3
//
//  Created by Marco Zulian on 01/12/21.
//

import Foundation
import SwiftUI

class SelectedProfileManager: ObservableObject {
    @Published var selectedProfile: ProfileModel
    
    init(profile: ProfileModel) {
        selectedProfile = profile
    }
    
    func getProfile() -> Color {
        selectedProfile.selectedColor
    }
    
    func getIdade() -> Int {
        let calendar = Calendar.current
        let birthdate = calendar.dateComponents([.year, .month, .day], from: selectedProfile.birthdate)
        let age: Int
        //Calculate age
        let now = calendar.dateComponents([.year, .month, .day], from: Date())
        let ageComponents = calendar.dateComponents([.year], from: birthdate, to: now)
        age = ageComponents.year!
        
        return age
    }
}
