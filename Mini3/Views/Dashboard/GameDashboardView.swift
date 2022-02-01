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
    @State var allFaceUp: Bool = true
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                Text("Jogos Disponíveis")
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .foregroundColor(selectedProfileManager.getProfileColor())
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .top, spacing: 30) {
                        ForEach(Game.allCases, id: \.rawValue) { game in
                            if game == .quebraCabeca {
                                GameCard(
                                    game: game,
                                    mascote: selectedProfileManager.getMascote(),
                                    profile: selectedProfileManager.getProfile(),
                                    allFaceUp: $allFaceUp,
                                    isActive: $isActive,
                                    hasSidebar: $hasSidebar,
                                    fractions: recordManager.getSatisfactionRates(jogo: game, student: selectedProfileManager.getProfile()))
                                    .environmentObject(selectedProfileManager)
                                    .padding(.vertical)
                            }
                        }
                    }
                }.frame(height: geo.size.height * 0.8)
                
                Spacer()
                
                Button(action: {allFaceUp.toggle()})
                {
                    HStack {
                        Image(systemName: allFaceUp ? "book" : "gamecontroller")
                        Text(allFaceUp ? "registros e informações" : "jogos educativos")
                    }
                    .font(.system(size: 21, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .background(
                        Capsule()
                            .frame(minWidth: 368, idealWidth: 368, maxWidth: 368, minHeight: geo.size.height * 0.1, idealHeight: geo.size.height * 0.1)
                            .foregroundColor(selectedProfileManager.getProfileColor())
                    )
                }
                
                Spacer()
            }
        }
        .fullScreenCover(isPresented: $recordManager.detailSheetShowing, onDismiss: {}) {
            DesempenhoDetalheView()
                .environmentObject(selectedProfileManager)
        }
    }
}
