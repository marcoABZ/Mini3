//
//  GameDashboardView.swift
//  Mini3
//
//  Created by Marco Zulian on 17/11/21.
//

import SwiftUI

struct GameDashboardView: View {
    @EnvironmentObject var dashboardManager: DashboardManager
    @StateObject var selectedProfileManager: SelectedProfileManager
    @EnvironmentObject var recordManager: RecordManager
    @Binding var hasSidebar: Bool
    @State var isActive: Bool = false
    
    var body: some View {
        VStack {
            Text("Jogos Disponíveis")
                .font(.system(size: 24, weight: .bold, design: .rounded))
                .foregroundColor(selectedProfileManager.getProfileColor())
//                .padding(.bottom)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 30) {
                    ForEach(Game.allCases, id: \.rawValue) { game in
                        NavigationLink(
                            destination:
                                QuebraCabecaStartView(
                                    puzzleManager: PuzzleManager(settings: PuzzleConfiguration()),
                                    rootIsActive: $isActive)
                                        .environmentObject(selectedProfileManager),
                            isActive: $isActive
                        ) {
                            GameCard(game: game, mascote: selectedProfileManager.getMascote(), profile: selectedProfileManager.getProfile(), fractions: recordManager.getSatisfactionRates(jogo: game, student: selectedProfileManager.getProfile()))
                                .zIndex(3)
                        }
                        .isDetailLink(false)
//                        .disabled(!game.isAvailable())
                        .if(game.isAvailable()) { view in
                            view.simultaneousGesture(
                                TapGesture().onEnded {
                                    hasSidebar = false
                                    recordManager.currentGame = .quebraCabeca
                                }
                            )
                        }
//                        .padding(.top)
                        .padding(.vertical,32)
                        .padding(.leading)
                    }
                }
            }.zIndex(1)
        }
    }
}
