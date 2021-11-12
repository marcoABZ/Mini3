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
                    dashboardManager.profileListShowing.toggle()
                }) {
                    Text("Perfis")
                    Spacer()
                    Image(systemName: dashboardManager.profileListShowing ? "chevron.up" : "chevron.down")
                }
                .foregroundColor(.black)
                .font(.system(size: 20, design: .rounded).bold())
            }
            
            .padding()
            if profileManager.isEditingProfile || profileManager.addingProfile {
                makeList()
            } else {
                makeList()
            }
        }
        .navigationTitle("Astronimautas")
        .background(profileManager.neutralColor)
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
        .if(dashboardManager.profileListShowing) { view in
            view.listStyle(PlainListStyle())
        }
    }
}



struct MainView: View {
    
    @EnvironmentObject var dashboardManager: DashboardManager
    @EnvironmentObject var profileManager: ProfileManager
    
    
    //Apagar animacao e variavel abaixo
    @State var pct: Double = 0.0
    
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                HStack(alignment: .top) {
                    Button(action: {
                        profileManager.isEditingProfile = true
                    }) {
                        ZStack {
                            if profileManager.isEditingProfile {
                                Image(systemName: "photo.fill")
                                    .font(.system(size: 70))
                                    .foregroundColor(.gray)
                                    .frame(width: 110, height: 110)
                                    .background(.gray.opacity(0.5))
                                    .cornerRadius(12)
                            } else {
                                profileManager.selectedProfile?.image
                                    .font(.system(size: 70))
                                    .foregroundColor(.gray)
                                    .frame(width: 110, height: 110)
                                    .background(.gray.opacity(0.5))
                                    .cornerRadius(12)
                            }
                            
                            
                            
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
                        
                    }
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
                
                generateContent()
            }
            .padding(.leading, geometry.size.width > 900 ? 80 : 0)
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
        }
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
//                    .colorMultiply(profileManager.selectedProfile != nil ? profileManager.selectedProfile!.selectedColor : .clear)
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
            VStack {
                Text("Jogos Disponíveis")
                    .font(.system(size: 32, design: .rounded).bold())
                ScrollView(.horizontal) {
                    HStack(alignment: .top, spacing: 36) {
                        ForEach(0..<10) { i in
                            VStack(alignment: .leading, spacing: 6) {
                                if i <= dashboardManager.covers.count - 1 {
                                    if profileManager.coverUpdate {
                                        dashboardManager.covers[i].image
                                            .resizable()
                                            .cornerRadius(16)
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 220, height: 320)
                                            .padding(.bottom, 10)
                                    } else {
                                        dashboardManager.covers[i].image
                                            .resizable()
                                            .cornerRadius(16)
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 220, height: 320)
                                            .padding(.bottom, 10)
                                    }
                                    
                                    Text("\(dashboardManager.covers[i].title)")
                                        .font(.system(size: 17).bold())
                                    Text("\(dashboardManager.covers[i].description)")
                                } else {
                                    Rectangle()
                                        .frame(width: 233, height: 326)
                                        .foregroundColor(.gray)
                                        .cornerRadius(16)
                                }
                            }
                            .padding(.bottom,32)
                            .padding(.leading)
                        }
                    }
                }
                Spacer()
            }
        case .performance:
            Text("Desempenho")
                .font(.system(size: 32, design: .rounded).bold())
            ScrollView(.horizontal) {
                ZStack(alignment: .topLeading) {
                    GeometryReader { geometry in
                        ZStack {
                            Path { path in
                                path.addArc(center: CGPoint(x: geometry.size.width/2, y: geometry.size.width/2),
                                    radius: geometry.size.width/2,
                                    startAngle: Angle(degrees: 0),
                                    endAngle: Angle(degrees: 360),
                                    clockwise: true)
                            }
                            .stroke(Color.gray.opacity(0.3), lineWidth: 30)
                            if dashboardManager.pickerSelection == .games {
                                InnerRing(pct: self.pct).stroke(Color.green, style: StrokeStyle(lineWidth: 35, lineCap: .round, lineJoin: .round))
                    
                                Text("67%")
                                    .font(.system(size: 30).bold())
                            } else {
                                InnerRing(pct: self.pct).stroke(profileManager.getProfileColor(), style: StrokeStyle(lineWidth: 30, lineCap: .round, lineJoin: .round))
                                Text("67%")
                                    .font(.system(size: 26).bold())
                            }
                        }

                    }
                    .frame(width: 110, height: 110)
                    .padding(.leading,40)
                    .aspectRatio(1, contentMode: .fit)
                    .padding(20)
                
                    Image("perfPlaceholder")
                        .padding()
                    }
                    .onAppear() {
                        withAnimation(.easeInOut(duration: 3)) {
                            self.pct = 0.67
                            
                        }
                    }
               
                }
            }
        }
}


struct DashboardView: View {
    
    @EnvironmentObject var dashboardManager: DashboardManager
    @EnvironmentObject var profileManager: ProfileManager
    
    var body: some View {
        NavigationView {
            if profileManager.addingProfile{
                SideBarView()
                    .environmentObject(dashboardManager)
                    .environmentObject(profileManager)
            } else {
                SideBarView()
                    .environmentObject(dashboardManager)
                    .environmentObject(profileManager)
            }
            
            MainView()
                .environmentObject(dashboardManager)
                .environmentObject(profileManager)
        }
        .fullScreenCover(isPresented: $profileManager.profileNotSelected, onDismiss: {}) {
            SplashView()
                .environmentObject(profileManager)
                .environmentObject(dashboardManager)
        }
        .fullScreenCover(isPresented: $profileManager.isEditingProfile, onDismiss: {}) {
            ProfileView()
                .environmentObject(dashboardManager)
                .environmentObject(profileManager)
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
            .environmentObject(DashboardManager())
            .environmentObject(ProfileManager())
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
