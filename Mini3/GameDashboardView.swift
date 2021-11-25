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
    @Binding var hasSidebar: Bool
    @State var isActive: Bool = false
    
    var body: some View {
        VStack {
            Text("Jogos Disponíveis")
                .font(.system(size: 24, weight: .bold, design: .rounded))
                .foregroundColor(profileManager.getProfileColor())
                .padding(.bottom)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 30) {
                    //TODO: Iterar sobre os casos de Game ao invés de covers
                    ForEach(Game.allCases, id: \.rawValue) { game in
                        VStack(alignment: .leading, spacing: 6) {
                            if game.isAvailable() {
                                NavigationLink(
                                    destination: QuebraCabecaStartView(puzzleManager: PuzzleManager(settings: PuzzleConfiguration()),
                                                                       rootIsActive: $isActive),
                                    isActive: $isActive
                                ) {
                                        game.getCoverImage(mascote: profileManager.selectedProfile!.mascote)
                                            .resizable()
                                            .cornerRadius(16)
                                            .aspectRatio(contentMode: .fit)
        //                                    .frame(width: 220, height: 320)
                                            .padding(.vertical, 10)
                                            .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 4)
                                }
                                .isDetailLink(false)
                                .simultaneousGesture(
                                    TapGesture().onEnded {
                                        hasSidebar = false
                                        recordManager.currentGame = .quebraCabeca
                                        profileManager.editingProfile = profileManager.selectedProfile!
                                    }
                                )
                            } else {
                                ZStack {
                                    game.getCoverImage(mascote: profileManager.selectedProfile!.mascote)
                                        .resizable()
                                        .cornerRadius(16)
                                        .aspectRatio(contentMode: .fit)
    //                                    .frame(width: 220, height: 320)
                                        .padding(.vertical, 10)
                                        .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 4)
                                    Color.black
                                        .cornerRadius(16)
                                        .opacity(0.5)
                                        .padding(.vertical, 10)
                                    Image(systemName: "lock.slash.fill")
                                        .foregroundColor(.white)
                                        .font(.system(size: 64))
                                }
                            }
                            Text(game.rawValue)
                                .font(.system(size: 17, weight: .bold, design: .rounded))
                            Text(game.getDescription())
                                .font(.system(size: 14, weight: .regular, design: .rounded))
                        }
                        .padding(.bottom,32)
                        .padding(.leading)
                    }
                }
            }
        }
    }
}
