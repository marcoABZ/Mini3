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
    @StateObject var selectedProfileManager: SelectedProfileManager
    
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
                    makeList()
                } else {
                    Spacer()
                }
            }
            else {
                Spacer()
            }
        }
        .frame(width: dashboardManager.isSidebarOpen ? 300 : 60)
        .background(dashboardManager.isSidebarOpen ? Color("neutralColor") : selectedProfileManager.getProfileColor())
        .overlay(alignment: .topLeading) {
            Button(
                action:
                    { withAnimation(.easeIn(duration: 0.3))
                        { dashboardManager.isSidebarOpen.toggle() }
                    },
                label:
                    { Image(systemName: "sidebar.leading")
                        .foregroundColor(dashboardManager.isSidebarOpen ? .primary : .white)
                        .padding()
                        .font(.system(size: 24))
                    }
            )
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    @ViewBuilder func makeList() -> some View {
        List() {
            ForEach(profileManager.profiles) { profile in
                if dashboardManager.profileListShowing {
                    HStack {
                        Text(profile.name)
                            .foregroundColor(selectedProfileManager.getProfile() == profile ? .white : .primary)
                        Spacer()
                    }
                    .listRowBackground(selectedProfileManager.getProfile() == profile && dashboardManager.profileListShowing ? selectedProfileManager.getProfileColor() : Color("neutralColor"))
                    .gesture(
                        TapGesture()
                            .onEnded {
                                if selectedProfileManager.getProfile() != profile {
                                    self.selectedProfileManager.setSelectedProfile(profile: profile)
                                    withAnimation(.easeOut(duration: 0.3))
                                        { dashboardManager.isSidebarOpen.toggle() }
                                }
                            }
                    )
                }
            }
            
            NavigationLink(destination:
                            ProfileView()
                                .environmentObject(selectedProfileManager)) {
                Text("Novo aluno")
            }
            .listRowBackground(Color("neutralColor"))
            .simultaneousGesture(
                TapGesture().onEnded {
                    profileManager.mode = .add
                }
            )
        }
        .listStyle(PlainListStyle())
    }
}



struct MainView: View {
    
    @EnvironmentObject var dashboardManager: DashboardManager
    @EnvironmentObject var profileManager: ProfileManager
    @StateObject var selectedProfileManager: SelectedProfileManager
    @Binding var hasSidebar: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                HStack(alignment: .top) {
                    NavigationLink(destination:
                                    ProfileView(editingProfile: selectedProfileManager.getProfile())
                                        .environmentObject(selectedProfileManager))
                    {
                        ZStack {
                            selectedProfileManager.getImage()
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
                                    .background(selectedProfileManager.getProfileColor())
                                    .cornerRadius(18)
                                    .offset(x: 55, y: 55)
                                }
                            }
                        }
                    }.simultaneousGesture(
                        TapGesture().onEnded {
                            hasSidebar = false
                            profileManager.mode = .edit
                        }
                    )
                    .padding()
                    VStack(alignment: .leading) {
                        Text(selectedProfileManager.getName())
                            .font(.system(size: 24, design: .rounded).bold())
                        
                        if let age = selectedProfileManager.getIdade() {
                        Text("\(age) anos")
                            .font(.system(size: 14, design: .rounded))
                            .padding(.vertical, 2)
                        }
                    }
                    .padding()
                    makePicker()
                }
                generateContent()
            }
            .padding(.top)
            .padding(.leading, dashboardManager.isSidebarOpen ? 0 : 80)
            .onAppear() {
                UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor : UIColor.black], for: .selected)
                UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor : UIColor.white], for: .normal)
                
                // TODO: Linkar com a cor do perfil selecionado
                UISegmentedControl.appearance().backgroundColor = UIColor(selectedProfileManager.getProfileColor())
                
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
            UISegmentedControl.appearance().backgroundColor = UIColor(selectedProfileManager.getProfileColor())
        }
    }
    
    @ViewBuilder func generateContent() -> some View {
        switch dashboardManager.pickerSelection {
        case .games:
            GameDashboardView(selectedProfileManager: selectedProfileManager, hasSidebar: $hasSidebar)
        case .performance:
            DesempenhoView()
                .environmentObject(selectedProfileManager)
        }
    }
}


struct DashboardView: View {
    
    @StateObject var selectedProfileManager: SelectedProfileManager
    @State var hasSidebar: Bool = true
    
    var body: some View {
        HStack(spacing: 0) {
            if hasSidebar {
                SideBarView(selectedProfileManager: selectedProfileManager)
            }
            MainView(selectedProfileManager: selectedProfileManager, hasSidebar: $hasSidebar)
        }
        .navigationBarHidden(true)
    }
}

