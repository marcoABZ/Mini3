//
//  DashboardView.swift
//  Mini3
//
//  Created by Pablo Penas on 09/11/21.
//

import SwiftUI

struct SideBarView: View {
    @EnvironmentObject var dashboardManager: DashboardManager
    let alunos = ["Marco","Ana","Deborah","Pablo","Carol"]
    
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
            List(0..<alunos.count) { i in
                Button(action: {}) {
                    if dashboardManager.profileListShowing {
                        Text(alunos[i])
                    }
                }
            }
            .listStyle(SidebarListStyle())
            .onAppear(perform: {
                    UITableView.appearance().contentInset.top = -35
                })
        }
        .padding()
        .navigationTitle("Astronimautas")
    }
}



struct MainView: View {
    
    @EnvironmentObject var dashboardManager: DashboardManager
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Button(action: {}) {
                    ZStack {
                        Image(systemName: "photo.fill")
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
                                .background(dashboardManager.selectedColor)
                                .cornerRadius(18)
                                .offset(x: 55, y: 55)
                            }
                        }
                    }
                    
                }
                .padding()
                //TODO: Usar padding adaptavel pra quando esconder a side bar
//                .padding(.leading, 36)
                VStack(alignment: .leading) {
                    HStack {
                        Text("Maria")
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
            }
            
            generateContent()
        }
        .onAppear() {
            UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor : UIColor.black], for: .selected)
            UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor : UIColor.white], for: .normal)
            
            // TODO: Linkar com a cor do perfil selecionado
            UISegmentedControl.appearance().backgroundColor = UIColor(dashboardManager.selectedColor)
            
            UISegmentedControl.appearance().selectedSegmentTintColor = .white
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
                                if i <= dashboardManager.gamesAvailable.count - 1 {
                                    Image("\(dashboardManager.gamesAvailable[i].imageName)")
                                        .padding(.bottom, 10)
                                    Text("\(dashboardManager.gamesAvailable[i].title)")
                                        .font(.system(size: 17).bold())
                                    Text("\(dashboardManager.gamesAvailable[i].description)")
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
                
            }
        }
    }
}

struct DashboardView: View {
    
    @EnvironmentObject var dashboardManager: DashboardManager
    
    var body: some View {
        NavigationView {
            SideBarView()
                .environmentObject(dashboardManager)
            MainView()
                .environmentObject(dashboardManager)
        }
        
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
            .environmentObject(DashboardManager())
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
