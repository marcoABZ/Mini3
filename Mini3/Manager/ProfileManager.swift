//
//  ProfileManager.swift
//  Mini3
//
//  Created by Pablo Penas on 10/11/21.
//

import Foundation
import SwiftUI

class ProfileManager: ObservableObject {

    @Published var addingProfile: Bool = false
    @Published var isEditingProfile: Bool = false
    @Published var editingProfile = ProfileModel(name: "", birthdate: Date(), color: Color.init(red: 35/255, green: 37/255, blue: 38/255), image: "placeholder")
    @Published var selectedProfile: ProfileModel?
    
    @Published var coverUpdate: Bool = false
    
    @Published var editingIndex: Int = 0
    
    var profiles: [ProfileModel] = []
    
    let availableColors = [
        Color.init(red: 123/255, green: 86/255, blue: 202/255),
        Color.init(red: 94/255, green: 196/255, blue: 214/255),
        Color.init(red: 91/255, green: 142/255, blue: 90/255),
        Color.init(red: 231/255, green: 170/255, blue: 66/255),
        Color.init(red: 236/255, green: 109/255, blue: 92/255),
        Color.init(red: 222/255, green: 127/255, blue: 178/255),
    ]
    
    func dismissProfileView() {
        self.isEditingProfile = false
        self.addingProfile = false
    }
    
    func getProfileColor() -> Color {
        if selectedProfile != nil {
            return selectedProfile!.selectedColor
        } else {
            return Color("neutralColor")
        }
    }
    
    func getEditingProfileColor() -> Color {
        return editingProfile.selectedColor
    }
    
    func save(profile: ProfileModel, withImage image: Image) {
        if isEditingProfile {
            print("entrou editing")
//            editingProfile.image = image
            for i in 0..<profiles.count {
                if profiles[i] == selectedProfile! {
                    print("encontrou")
                    profiles[i] = profile
                    selectedProfile = profiles[i]
                }
            }
        } else if addingProfile {
            print("entrou adding")
            profiles.append(profile)
            selectedProfile = profiles.last
        }
        dismissProfileView()
    }
    
    func getFinishImage() -> Image {
//        selectedProfile = profiles[editingIndex]
        switch selectedProfile!.mascote {
        case .chiba:
            return Image("chibaFinish")
        case.gato:
            return Image("gatoFinish")
        case .coelho:
            return Image("coelhoFinish")
        }
    }
    
    func updateEditingProfile(index: Int) {
        editingProfile = profiles[index]
    }
    
    func getIdade() -> Int? {
        if let selectedProfile = selectedProfile {
            let calendar = Calendar.current
            let birthdate = calendar.dateComponents([.year, .month, .day], from: selectedProfile.birthdate)
            let age: Int
            //Calculate age
            let now = calendar.dateComponents([.year, .month, .day], from: Date())
            let ageComponents = calendar.dateComponents([.year], from: birthdate, to: now)
            age = ageComponents.year!
            
            return age
        }
        
        return nil
    }
    
    static func getDefaultProfile() -> ProfileModel {
        ProfileModel(name: "", birthdate: Date(), color: Color.init(red: 35/255, green: 37/255, blue: 38/255), image: "placeholder")
    }
}
