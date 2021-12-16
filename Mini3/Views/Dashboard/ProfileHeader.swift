//
//  ProfileHeader.swift
//  Mini3
//
//  Created by Marco Zulian on 13/12/21.
//

import SwiftUI

struct ProfileHeader: View {
    
    @EnvironmentObject var selectedProfileManager: SelectedProfileManager
    
    var body: some View {
        userProfileImage
            .padding(.leading)
        userDescriptionInfo
    }
    
    var userProfileImage: some View {
        ZStack {
            selectedProfileManager.getImage()
//                    .font(.system(size: 70))
//                    .foregroundColor(.gray)
                .frame(width: 110, height: 110)
//                    .background(.gray.opacity(0.5))
                .cornerRadius(12)
            
            VStack {
                HStack {
                    Image(systemName: "gearshape")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)
                        .padding(2)
                        .background(Circle().foregroundColor(selectedProfileManager.getProfileColor()))
                    .frame(width: 36, height: 36)
                    .offset(x: 55, y: 55)
                }
            }
        }
    }
    
    var userDescriptionInfo: some View {
        VStack(alignment: .leading) {
            Text(selectedProfileManager.getName())
                .font(.system(size: 24, design: .rounded).bold())
            
//            if let age = selectedProfileManager.getIdade() {
//            Text("\(age) anos")
//                .font(.system(size: 14, design: .rounded))
//                .padding(.vertical, 2)
//            }
        }
        .padding()
    }
}
