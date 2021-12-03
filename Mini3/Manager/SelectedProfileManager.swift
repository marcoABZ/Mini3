//
//  SelectedProfileManager.swift
//  Mini3
//
//  Created by Marco Zulian on 01/12/21.
//

import Foundation
import SwiftUI

class SelectedProfileManager: ObservableObject, CustomStringConvertible {
    var description: String { "Nome: \(selectedProfile.name) " }
    
    @Published var selectedProfile: ProfileModel
    
    init() {
        selectedProfile = ProfileManager.getDefaultProfile()
    }
    
    init(profile: ProfileModel) {
        selectedProfile = profile
    }
    
    func getProfile() -> ProfileModel {
        selectedProfile
    }
    
    func setSelectedProfile(profile: ProfileModel) {
        selectedProfile = profile
    }
    
    func getImage() -> Image {
        selectedProfile.image
    }
    
    func getName() -> String {
        selectedProfile.name
    }
    
    func getProfileColor() -> Color {
        selectedProfile.selectedColor
    }
    
    func getMascote() -> Mascotes {
        selectedProfile.mascote
    }
    
    func getID() -> UUID {
        selectedProfile.id
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
    
    func getFinishImage() -> Image {
//        selectedProfile = profiles[editingIndex]
        switch selectedProfile.mascote {
        case .chiba:
            return Image("chibaFinish")
        case.gato:
            return Image("gatoFinish")
        case .coelho:
            return Image("coelhoFinish")
        }
    }
}
