//
//  SplashView.swift
//  Mini3
//
//  Created by Pablo Penas on 11/11/21.
//

import SwiftUI

struct ProfileListView: View {
    @EnvironmentObject var profileManager: ProfileManager
//    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {

        ScrollView(.horizontal) {
            HStack {
                VStack {
                    Button(action: {
                        profileManager.addingProfile = true
                    }) {
                        Rectangle()
                            .fill(LinearGradient(gradient: Gradient(colors: [.white, .white.opacity(0)]), startPoint: .topTrailing, endPoint: .bottomLeading))
                            .frame(width: 204, height: 204)
                            .cornerRadius(16)
                            .blur(radius: 5)
                            .overlay(
                                Image(systemName: "plus").font(.system(size: 90).bold())).foregroundColor(Color("SplashPurple")
                                )
                    }
                        
                    Text("Novo perfil")
                        .foregroundColor(.white)
                        .font(.system(size: 21).bold())
                        .padding(.top, 16)
                }
                .padding(.leading,profileManager.profiles.count > 4 ? 120 : 0)
                .padding(.trailing,16)
                ForEach(0..<profileManager.profiles.count) { index in
                    VStack {
                        Button(action: {
                            profileManager.profileNotSelected = false
                            profileManager.selectedProfile = profileManager.profiles[index]
                        }) {
                            profileManager.profiles[index].image
                                .frame(width: 165, height: 165)
                                .cornerRadius(16)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(.white, lineWidth: 1)
                                )
                                .padding(.horizontal,8)
                        }
                        
                        Text(profileManager.profiles[index].name)
                            .foregroundColor(.white)
                            .font(.system(size: 17).bold())
                            .padding(.top,8)
                            
                    }
                    
                }
            }
            .padding(.trailing, 80)
            
            .padding(.vertical,120)
        }
        .frame(maxHeight: 210)
    }
}

struct SplashView: View {
    @EnvironmentObject var profileManager: ProfileManager
    var body: some View {
        ZStack {
            Image("SplashBackground")
            VStack {
                Image("logo")
                Text("Crie um perfil para começar!")
                    .font(.system(size: 36).bold())
                    .foregroundColor(.white)
                    .padding(.top, 64)
                if profileManager.addingProfile {
                    ProfileListView()
                        .padding(.top, 40)
                        .environmentObject(profileManager)
                } else {
                    ProfileListView()
                        .padding(.top, 40)
                        .environmentObject(profileManager)
                }
                
            }
        }
        .fullScreenCover(isPresented: $profileManager.addingProfile, onDismiss: {profileManager.addingProfile = false}) {
            ProfileView()
                .environmentObject(profileManager)
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
            .previewInterfaceOrientation(.landscapeLeft)
            .environmentObject(ProfileManager())
    }
}
