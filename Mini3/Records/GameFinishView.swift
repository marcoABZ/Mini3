//
//  GameFinishView.swift
//  Mini3
//
//  Created by Pablo Penas on 17/11/21.
//

import SwiftUI

struct GameFinishView: View {
    @EnvironmentObject var profileManager: ProfileManager
    var body: some View {
        ZStack {
            profileManager.availableColors[0]
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(.white.opacity(0.3), lineWidth: 5)
                )
                .ignoresSafeArea()
            FinishMenuView()
                .environmentObject(profileManager)
        }
        
    }
    
}

struct GameFinishView_Previews: PreviewProvider {
    static var previews: some View {
        GameFinishView()
            .padding()
            .environmentObject(ProfileManager())
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
