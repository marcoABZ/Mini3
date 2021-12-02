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
    
    @Published var coverUpdate: Bool = false
    
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
    
    func save(profile: ProfileModel, withImage image: Image) {
        if isEditingProfile {
            print("entrou editing")
            for i in 0..<profiles.count {
                if profiles[i].id == profile.id {
                    print("encontrou")
                    profiles[i] = profile
                }
            }
        } else if addingProfile {
            print("entrou adding")
            profiles.append(profile)
        }
        dismissProfileView()
    }
    
    static func getDefaultProfile() -> ProfileModel {
        ProfileModel(name: "", birthdate: Date(), color: Color.init(red: 35/255, green: 37/255, blue: 38/255), image: "placeholder")
    }
}
