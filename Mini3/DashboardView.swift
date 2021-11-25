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
        VStack (alignment: .leading){
            if (dashboardManager.isSidebarOpen) {
                Image("logoSidebar")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 200)
                    .padding(.top, 70)
                    .padding(.horizontal)
                    .padding(.bottom, 20)
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
                    .padding(.horizontal)
                    .font(.system(size: 20, design: .rounded).bold())
                }
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
            else {
                Spacer()
            }
        }
        .frame(width: dashboardManager.isSidebarOpen ? 300 : 60)
        .background(dashboardManager.isSidebarOpen ? Color("neutralColor") : profileManager.getProfileColor())
        .overlay(alignment: .topLeading) {
            Button(
                action:
                    { withAnimation(.easeIn(duration: 0.3))
                        { dashboardManager.isSidebarOpen.toggle() }
                    },
                label:
                    { Image(systemName: "sidebar.leading")
                        .foregroundColor(.primary)
                        .padding()
                        .font(.system(size: 24))
                    }
            )
        }
        .navigationViewStyle(StackNavigationViewStyle())
//        .background(Color("neutralColor"))
    }
    
    @ViewBuilder func makeList() -> some View {
        List(0 ..< profileManager.profiles.count) { i in
            Button(action: {
                if profileManager.selectedProfile != profileManager.profiles[i] {
                    profileManager.selectedProfile = profileManager.profiles[i]
                    dashboardManager.getGamesAvailable(mascote: profileManager.selectedProfile!.mascote)
                    profileManager.coverUpdate.toggle()
                }
                
            }) {
                if dashboardManager.profileListShowing {
                    HStack {
                        Text(profileManager.profiles[i].name)
                        Spacer()
                    }
                }
            }
            .listRowBackground(profileManager.selectedProfile == profileManager.profiles[i] && dashboardManager.profileListShowing ? profileManager.selectedProfile!.selectedColor : Color("neutralColor"))
        }
        .listStyle(PlainListStyle())
//        .if(dashboardManager.profileListShowing) { view in
//            view.listStyle(PlainListStyle())
//        }
    }
}



struct MainView: View {
    
    @EnvironmentObject var dashboardManager: DashboardManager
    @EnvironmentObject var profileManager: ProfileManager
    @Binding var hasSidebar: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                HStack(alignment: .top) {
                    NavigationLink(destination: ProfileView()) {
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
                        TapGesture().onEnded {
                            hasSidebar = false
//                            dashboardManager.hasSidebar = false
                            profileManager.isEditingProfile = true
                        }
                    )
                    .padding()
                    VStack(alignment: .leading) {
                        Text(profileManager.selectedProfile != nil ? profileManager.selectedProfile!.name : "Maria")
                            .font(.system(size: 24, design: .rounded).bold())
                        
                        if let age = profileManager.getIdade() {
                        Text("\(age) anos")
                            .font(.system(size: 14, design: .rounded))
                            .padding(.vertical, 2)
                        }
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
            .padding(.top)
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
                hasSidebar = true
            }
            .navigationBarHidden(true)
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
            GameDashboardView(hasSidebar: $hasSidebar)
        case .performance:
            DesempenhoView()
        }
    }
}


struct DashboardView: View {
    
    @EnvironmentObject var dashboardManager: DashboardManager
    @EnvironmentObject var profileManager: ProfileManager
    @State var hasSidebar: Bool = true
    
    var body: some View {
        HStack(spacing: 0) {
            if hasSidebar {
                SideBarView()
//                    .frame(width: 300)
            }
            MainView(hasSidebar: $hasSidebar)
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
