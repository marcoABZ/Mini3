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
    
    var body: some View {
        VStack {
            Text("Jogos Disponíveis")
                .font(.system(size: 32, design: .rounded).bold())
            ScrollView(.horizontal) {
                HStack(alignment: .top, spacing: 36) {
                    ForEach(0..<10) { i in
                        VStack(alignment: .leading, spacing: 6) {
                            if i <= dashboardManager.covers.count - 1 {
                                NavigationLink(destination: QuebraCabecaStartView(puzzleManager: PuzzleManager(settings: PuzzleConfiguration()))) {
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
    }
}
