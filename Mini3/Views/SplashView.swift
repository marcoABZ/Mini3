//
//  SplashView.swift
//  Mini3
//
//  Created by Pablo Penas on 11/11/21.
//

import SwiftUI
import AVFAudio

struct ProfileListView: View {
    @EnvironmentObject var profileManager: ProfileManager
    @EnvironmentObject var dashboardManager: DashboardManager
    
    var body: some View {

        ScrollView(.horizontal) {
            HStack {
                NavigationLink(destination: ProfileView()
                                .environmentObject(SelectedProfileManager())) {
                    VStack {
                        Rectangle()
                            .fill(LinearGradient(gradient: Gradient(colors: [.white, .white.opacity(0)]), startPoint: .topTrailing, endPoint: .bottomLeading))
                            .frame(width: 204, height: 204)
                            .cornerRadius(16)
                            .blur(radius: 5)
                            .overlay(
                                Image(systemName: "plus").font(.system(size: 90).bold())).foregroundColor(Color("SplashPurple")
                                )
                        
                        Text("Novo perfil")
                            .foregroundColor(.white)
                            .font(.system(size: 21).bold())
                            .padding(.top, 16)
                    }
                    .padding(.leading,profileManager.profiles.count > 4 ? 120 : 0)
                    .padding(.trailing,16)
                }.simultaneousGesture(
                    TapGesture().onEnded {
                        profileManager.mode = .add
                    }
                )
                
                ForEach(profileManager.profiles) { prof in
                    let manager = SelectedProfileManager(profile: prof)
                    NavigationLink(destination:
                                    DashboardView(selectedProfileManager: manager)
                    ) {
                        VStack {
                            prof.image
                                .frame(width: 165, height: 165)
                                .cornerRadius(16)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(.white, lineWidth: 1)
                                )
                                .padding(.horizontal,8)
                            
                            Text(prof.name)
                                .foregroundColor(.white)
                                .font(.system(size: 17).bold())
                                .padding(.top,8)
                        }
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
    @EnvironmentObject var dashboardManager: DashboardManager
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("SplashBackground")
                VStack {
                    Image("logo")
                    Text("Crie um perfil para começar!")
                        .font(.system(size: 36).bold())
                        .foregroundColor(.white)
                        .padding(.top, 64)
                    ProfileListView()
                        .padding(.top, 40)
                        .environmentObject(profileManager)
                    
                }
            }.navigationBarHidden(true)
            .ignoresSafeArea(.all)
        }
        .statusBar(hidden: true)
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationAppearance(foregroundColor: .white, tintColor: .white, hideSeparator: true)
    }
}
