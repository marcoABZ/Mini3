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
    
    @Published var profileNotSelected: Bool = true
    
    @Published var editingProfile = ProfileModel(name: "", birthdate: Date(), color: Color.init(red: 242/255, green: 242/255, blue: 247/255), image: "placeholder")
    
    @Published var selectedProfile: ProfileModel?
    
    let neutralColor = Color.init(red: 242/255, green: 242/255, blue: 247/255)
    
    @Published var coverUpdate: Bool = false
    
    let availableColors = [
        Color.init(red: 123/255, green: 86/255, blue: 202/255),
        Color.init(red: 94/255, green: 196/255, blue: 214/255),
        Color.init(red: 91/255, green: 142/255, blue: 90/255),
        Color.init(red: 231/255, green: 170/255, blue: 66/255),
        Color.init(red: 236/255, green: 109/255, blue: 92/255),
        Color.init(red: 222/255, green: 127/255, blue: 178/255),
    ]
    
    let testProfiles = ["Marco","Ana", "Carol", "Pablo", "Deborah"]
    let testBirthdates = [
        Calendar.current.date(from: DateComponents(year: 1999, month: 5, day: 27)),
        Calendar.current.date(from: DateComponents(year: 1999, month: 5, day: 27)),
        Calendar.current.date(from: DateComponents(year: 1999, month: 5, day: 27)),
        Calendar.current.date(from: DateComponents(year: 1999, month: 5, day: 27)),
        Calendar.current.date(from: DateComponents(year: 1999, month: 5, day: 27)),
    ]
    let testProfilesImages = ["profile1","profile2","profile3","profile4","profile4"]
    
    var profiles: [ProfileModel] = []
    
    init() {
        for i in 0..<testProfiles.count {
            profiles.append(
                ProfileModel(name: testProfiles[i], birthdate: testBirthdates[i]!, color: availableColors.randomElement()!, image: testProfilesImages.randomElement()!)
            )
        }
        selectedProfile = profiles[0]
    }
    
    func dismissProfileView() {
        self.isEditingProfile = false
        self.addingProfile = false
    }
    
    func getProfileColor() -> Color {
        if selectedProfile != nil {
            return selectedProfile!.selectedColor
        } else {
            return neutralColor
        }
    }
    
    func getProfile() {
        if selectedProfile != nil {
            editingProfile = selectedProfile!
        } else {
            editingProfile = ProfileModel(name: "", birthdate: Date(), color: neutralColor, image: "placeholder")
        }

    }
    
    func saveProfile(image: Image) {
        if isEditingProfile {
            editingProfile.image = image
            for i in 0..<profiles.count {
                if profiles[i] == selectedProfile! {
                    profiles[i] = editingProfile
                    selectedProfile = editingProfile
                }
            }
        } else if addingProfile {
            editingProfile.image = image
            profiles.append(editingProfile)
            selectedProfile = editingProfile
        }
        dismissProfileView()
    }
}
