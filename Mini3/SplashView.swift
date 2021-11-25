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
//    @Environment(\.presentationMode) var presentationMode
//    @State var sound: AVAudioPlayer?
    
    var body: some View {

        ScrollView(.horizontal) {
            HStack {
                
                NavigationLink(destination: ProfileView()) {
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
                    TapGesture().onEnded { profileManager.addingProfile = true }
                )
                
                ForEach(0..<profileManager.profiles.count) { index in

                    NavigationLink(destination: DashboardView()) {
                        VStack {
                            profileManager.profiles[index].image
                                .frame(width: 165, height: 165)
                                .cornerRadius(16)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(.white, lineWidth: 1)
                                )
                                .padding(.horizontal,8)
                            
                            Text(profileManager.profiles[index].name)
                                .foregroundColor(.white)
                                .font(.system(size: 17).bold())
                                .padding(.top,8)
                        }
                    }.simultaneousGesture(
                        TapGesture().onEnded {
                            profileManager.profileNotSelected = false
                            profileManager.selectedProfile = profileManager.profiles[index]
                        }
                    )
                }
            }
            .padding(.trailing, 80)
            
            .padding(.vertical,120)
        }
        .frame(maxHeight: 210)
//        .onAppear {
//            sound = createSoundPlayer(sound: "tiruliru", type: "wav")
//            sound?.numberOfLoops = -1
//            sound?.play()
//        }
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
//                    if profileManager.addingProfile {
                    ProfileListView()
                        .padding(.top, 40)
                        .environmentObject(profileManager)
//                    } else {
//                        ProfileListView()
//                            .padding(.top, 40)
//                            .environmentObject(profileManager)
//                    }
                    
                }
            }.navigationBarHidden(true)
            .ignoresSafeArea(.all)
//            .fullScreenCover(isPresented: $profileManager.addingProfile, onDismiss: {profileManager.addingProfile = false}) {
//                ProfileView()
//                    .environmentObject(profileManager)
//                    .environmentObject(dashboardManager)
//            }
        }.navigationViewStyle(StackNavigationViewStyle())
        .navigationAppearance(foregroundColor: .white, tintColor: .white, hideSeparator: true)
    }
}

//struct SplashView_Previews: PreviewProvider {
//    static var previews: some View {
//        SplashView()
//            .previewInterfaceOrientation(.landscapeLeft)
//            .environmentObject(ProfileManager())
//            .environmentObject(DashboardManager())
//    }
//}
