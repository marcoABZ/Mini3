//
//  ProfileManager.swift
//  Mini3
//
//  Created by Pablo Penas on 10/11/21.
//

import Foundation
import SwiftUI

class ProfileManager: ObservableObject {

    enum ProfileViewStatus {
        case add
        case edit
    }
    
    var mode: ProfileViewStatus = .add
    @Published var profiles: [ProfileModel] = []
    
    init() {
        self.profiles = CoreDataManager.shared.getAllProfiles()
    }
    
    let availableColors = [
        UIColor.init(red: 123/255, green: 86/255, blue: 202/255, alpha: 1),
        UIColor.init(red: 94/255, green: 196/255, blue: 214/255, alpha: 1),
        UIColor.init(red: 91/255, green: 142/255, blue: 90/255, alpha: 1),
        UIColor.init(red: 231/255, green: 170/255, blue: 66/255, alpha: 1),
        UIColor.init(red: 236/255, green: 109/255, blue: 92/255, alpha: 1),
        UIColor.init(red: 222/255, green: 127/255, blue: 178/255, alpha: 1),
    ]

    func save(profile: ProfileModel, withImage image: Image) {
        switch mode {
        case .edit:
            for i in 0..<profiles.count {
                if profiles[i].id == profile.id {
                    profiles[i] = profile
                    CoreDataManager.shared.update(profile: profile)
                }
            }
        case .add:
            profiles.append(profile)
            CoreDataManager.shared.save(profile: profile)
        }
    }
    
    func delete(profile: ProfileModel) {
        let index = profiles.firstIndex(of: profile)
        
        if let index = index {
            profiles.remove(at: index)
            CoreDataManager.shared.deleteProfile(profile: profile)
        }
    }
    
    static func getDefaultProfile() -> ProfileModel {
        ProfileModel(name: "", birthdate: Date(), color: UIColor.init(red: 35/255, green: 37/255, blue: 38/255, alpha: 1), image: "placeholder")
    }
}
