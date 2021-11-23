//
//  GameFinishView.swift
//  Mini3
//
//  Created by Pablo Penas on 17/11/21.
//

import SwiftUI

struct GameFinishView: View {
    @EnvironmentObject var profileManager: ProfileManager
    @EnvironmentObject var recordManager: RecordManager
    
    var body: some View {
        ZStack {
            if profileManager.editingIndex == 1 {
                profileManager.getProfileColor()
                    .cornerRadius(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(.white.opacity(0.3), lineWidth: 5)
                    )
                    .ignoresSafeArea()
            } else {
                profileManager.getProfileColor()
                    .cornerRadius(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(.white.opacity(0.3), lineWidth: 5)
                    )
                    .ignoresSafeArea()
            }
            switch recordManager.recordViewMode {
            case .menu:
                FinishMenuView()
                    .environmentObject(profileManager)
                    .environmentObject(recordManager)
            case .teacherEdit:
                TeacherRegisterView()
                    .environmentObject(profileManager)
                    .environmentObject(recordManager)
            case .input:
                RegisterView()
                    .environmentObject(profileManager)
                    .environmentObject(recordManager)
            }
        }
        
    }
    
}

struct GameFinishView_Previews: PreviewProvider {
    static var previews: some View {
        GameFinishView()
            .padding()
            .environmentObject(ProfileManager())
            .environmentObject(RecordManager())
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
