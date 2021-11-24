//
//  GameDashboardView.swift
//  Mini3
//
//  Created by Marco Zulian on 17/11/21.
//

import SwiftUI

struct GameDashboardView: View {
    @EnvironmentObject var dashboardManager: DashboardManager
    @EnvironmentObject var profileManager: ProfileManager
    
    //recordmanager instanciado para poder captar o dado do jogo atual
    @EnvironmentObject var recordManager: RecordManager
    
    var body: some View {
        VStack {
            Text("Jogos Disponíveis")
                .font(.system(size: 24, weight: .bold, design: .rounded))
                .foregroundColor(profileManager.getProfileColor())
                .padding(.bottom)
            ScrollView(.horizontal) {
                HStack(alignment: .top, spacing: 30) {
                    //TODO: Iterar sobre os casos de Game ao invés de covers
                    ForEach(dashboardManager.covers, id: \.title) { cover in
                        VStack(alignment: .leading, spacing: 6) {
                            if cover.game.isAvailable() {
                                NavigationLink(destination: QuebraCabecaStartView(puzzleManager: PuzzleManager(settings: PuzzleConfiguration()))) {
                                        cover.image
                                            .resizable()
                                            .cornerRadius(16)
                                            .aspectRatio(contentMode: .fit)
        //                                    .frame(width: 220, height: 320)
                                            .padding(.bottom, 10)
                                            .shadow(color: .gray, radius: 10, x: 0, y: 0)
                                }
                                .simultaneousGesture(
                                    TapGesture().onEnded {
                                        dashboardManager.hasSidebar = false
                                        recordManager.currentGame = .quebraCabeca
                                    }
                                )
                            } else {
                                ZStack {
                                    cover.image
                                        .resizable()
                                        .cornerRadius(16)
                                        .aspectRatio(contentMode: .fit)
    //                                    .frame(width: 220, height: 320)
                                        .padding(.bottom, 10)
                                        .shadow(color: .gray, radius: 10, x: 0, y: 0)
                                    Color.black
                                        .cornerRadius(16)
                                        .opacity(0.5)
                                        .padding(.bottom, 10)
                                    Image(systemName: "lock.slash.fill")
                                        .foregroundColor(.white)
                                        .font(.system(size: 64))
                                }
                            }
                            Text(cover.title)
                                .font(.system(size: 17, weight: .bold, design: .rounded))
                            Text(cover.description)
                                .font(.system(size: 14, weight: .regular, design: .rounded))
                        }
                        .padding(.bottom,32)
                        .padding(.leading)
                    }
                }
            }
//            Spacer()
        }.onAppear { dashboardManager.getGamesAvailable(mascote: profileManager.selectedProfile?.mascote ?? .chiba) }
    }
}
