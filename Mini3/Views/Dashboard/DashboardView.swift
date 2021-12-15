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
    @EnvironmentObject var recordManager: RecordManager
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
        .frame(width: dashboardManager.isSidebarOpen ? 300 : 70)
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
                        .font(.system(size: 32))
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
                    .contentShape(Rectangle())
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
            }.onDelete(perform: delete)
            
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
    
    func delete(at offsets: IndexSet) {
        let profile = offsets.map { self.profileManager.profiles[$0] }.first!
        recordManager.eraseAllRecords(forStudent: profile)
        profileManager.delete(profile: profile)
    }
}



struct MainView: View {
    
    @EnvironmentObject var dashboardManager: DashboardManager
    @EnvironmentObject var profileManager: ProfileManager
    @StateObject var selectedProfileManager: SelectedProfileManager
    @Binding var hasSidebar: Bool
    
    var body: some View {
        GeometryReader { geo in
            NavigationView {
                VStack(alignment: .leading) {
                    NavigationLink(destination:
                                    ProfileView(editingProfile: selectedProfileManager.getProfile())
                                        .environmentObject(selectedProfileManager))
                    {
                        ProfileHeader()
                            .environmentObject(selectedProfileManager)
                    }
                    .simultaneousGesture( TapGesture().onEnded {
                        hasSidebar = false
                        profileManager.mode = .edit
                    })
                    
                    GameDashboardView(selectedProfileManager: selectedProfileManager, hasSidebar: $hasSidebar)
                        .frame(height: geo.size.height * 0.75)
                    
                }
                .padding(.top)
                .padding(.leading, dashboardManager.isSidebarOpen ? 0 : 50)
                .onAppear() {
                    hasSidebar = true
                }
                .navigationBarHidden(true)
                .navigationBarTitleDisplayMode(.inline)
            }.navigationViewStyle(StackNavigationViewStyle())
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

