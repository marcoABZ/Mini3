//
//  DashboardView.swift
//  Mini3
//
//  Created by Pablo Penas on 09/11/21.
//

import SwiftUI

struct SideBarView: View {
    @EnvironmentObject var dashboardManager: DashboardManager
    @EnvironmentObject var profileManager: ProfileManager
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    withAnimation {
                        dashboardManager.profileListShowing.toggle()
                    }
                }) {
                    Text("Perfis")
                    Spacer()
                    Image(systemName: dashboardManager.profileListShowing ? "chevron.up" : "chevron.down")
                }
                .font(.system(size: 20, design: .rounded).bold())
            }
            .padding()
            if dashboardManager.profileListShowing {
                if profileManager.coverUpdate {
                    makeList()
                } else {
                    makeList()
                }
            } else {
                Spacer()
            }
        }
        .background(Color("neutralColor"))
    }
    
    @ViewBuilder func makeList() -> some View {
        List(0..<profileManager.profiles.count) { i in
            Button(action: {
                profileManager.selectedProfile = profileManager.profiles[i]
                dashboardManager.getGamesAvailable(mascote: profileManager.selectedProfile!.mascote)
                profileManager.coverUpdate.toggle()
                
            }) {
                if dashboardManager.profileListShowing {
                    HStack {
                        Text(profileManager.profiles[i].name)
                        Spacer()
                    }
                }
            }
            .listRowBackground(profileManager.selectedProfile == profileManager.profiles[i] && dashboardManager.profileListShowing ? profileManager.selectedProfile!.selectedColor : .clear)
        }
        .listStyle(SidebarListStyle())
        .if(dashboardManager.profileListShowing) { view in
            view.listStyle(PlainListStyle())
        }
    }
}



struct MainView: View {
    
    @EnvironmentObject var dashboardManager: DashboardManager
    @EnvironmentObject var profileManager: ProfileManager
    
    var body: some View {
        NavigationView {
            VStack {
                HStack(alignment: .top) {
                    NavigationLink(destination: ProfileView()) {
                    
//                    Button(action: {
//                        profileManager.isEditingProfile = true
//                    }) {
                        ZStack {
                            profileManager.selectedProfile?.image
                                .font(.system(size: 70))
                                .foregroundColor(.gray)
                                .frame(width: 110, height: 110)
                                .background(.gray.opacity(0.5))
                                .cornerRadius(12)
                            
                            VStack {
                                HStack {
                                    Image(systemName: "gearshape")
                                        .font(.system(size: 24, weight: .bold))
                                        .foregroundColor(.white)
                                    .frame(width: 36, height: 36)
                                    .background(profileManager.selectedProfile?.selectedColor)
                                    .cornerRadius(18)
                                    .offset(x: 55, y: 55)
                                }
                            }
                        }
                        
                    }.simultaneousGesture(
                        TapGesture().onEnded {profileManager.isEditingProfile = true}
                    )
                    .padding()
                    VStack(alignment: .leading) {
                        HStack {
                            Text(profileManager.selectedProfile != nil ? profileManager.selectedProfile!.name : "Maria")
                            Image(systemName: "gamecontroller")
                        }
                        .font(.system(size: 24, design: .rounded).bold())
                        
                        Text("8 anos")
                            .font(.system(size: 14, design: .rounded))
                            .padding(.vertical, 2)
                        Text("Interesse: balas de goma")
                            .font(.system(size: 14, design: .rounded))

                    }
                    .padding()
                    if dashboardManager.renderView {
                        makePicker()
                    } else {
                        makePicker()
                    }
                }
                if dashboardManager.renderView {
                    generateContent()
                } else {
                    generateContent()
                }
            }
            .padding(.leading, dashboardManager.isSidebarOpen ? 0 : 80)
            .onChange(of: profileManager.selectedProfile) { _ in
                dashboardManager.renderView.toggle()
            }
            .onAppear() {
                UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor : UIColor.black], for: .selected)
                UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor : UIColor.white], for: .normal)
                
                // TODO: Linkar com a cor do perfil selecionado
//                UISegmentedControl.appearance().backgroundColor = UIColor(profileManager.selectedColor)
                
                UISegmentedControl.appearance().selectedSegmentTintColor = .white
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(
                        action:
                            { withAnimation(.easeIn(duration: 0.3))
                                { dashboardManager.isSidebarOpen.toggle() }
                            },
                        label:
                            { Image(systemName: "sidebar.leading")
                                .foregroundColor(.primary)
                            }
                    )
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }.navigationViewStyle(StackNavigationViewStyle())
    }
    
    @ViewBuilder func makePicker() -> some View {
        Picker("Visualização", selection: $dashboardManager.pickerSelection) {
            ForEach(0..<ViewModes.allCases.count) {
                Text(ViewModes.allCases[$0].rawValue)
                    .fontWeight(.bold)
                    .tag(ViewModes.allCases[$0])
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding(.leading,64)
        .padding(.trailing,64)
        .padding(.vertical,34)
        .onAppear() {
            UISegmentedControl.appearance().backgroundColor = UIColor(profileManager.selectedProfile != nil ? profileManager.selectedProfile!.selectedColor : .gray)
        }
    }
    
    @ViewBuilder func generateContent() -> some View {
        switch dashboardManager.pickerSelection {
        case .games:
            GameDashboardView()
        case .performance:
            DesempenhoView()
        }
    }
}


struct DashboardView: View {
    
    @EnvironmentObject var dashboardManager: DashboardManager
    @EnvironmentObject var profileManager: ProfileManager
    
    var body: some View {
        HStack(spacing: 0) {
            if dashboardManager.isSidebarOpen {
                SideBarView()
                    .frame(width: 300)
            }
            MainView()
        }
//        .gesture (
//            DragGesture()
//                .onChanged({gesture in
//                    if gesture.startLocation.x < CGFloat(100.0) && !dashboardManager.isSidebarOpen {
//                        withAnimation(.easeIn(duration: 0.3)) {
//                            dashboardManager.isSidebarOpen = true
//                        }
//                    }
//                 })
//        )
//        .fullScreenCover(isPresented: $profileManager.profileNotSelected, onDismiss: {}) {
//            SplashView()
//        }
//        .fullScreenCover(isPresented: $profileManager.isEditingProfile, onDismiss: {}) {
//            ProfileView()
//        }
        .navigationBarHidden(true)
        .navigationAppearance(foregroundColor: .white, tintColor: .white, hideSeparator: true)
    }
}

//struct DashboardView_Previews: PreviewProvider {
//    static var previews: some View {
//        DashboardView()
//            .environmentObject(DashboardManager())
//            .environmentObject(ProfileManager())
//            .previewInterfaceOrientation(.landscapeLeft)
//    }
//}
