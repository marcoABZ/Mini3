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
    @Binding var presented: Bool
    @Binding var shouldPopToRoot: Bool
    @Binding var selectedProfile: ProfileModel
    
    var body: some View {
        ZStack {
            selectedProfile.selectedColor
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(.white.opacity(0.3), lineWidth: 5)
                )
                .ignoresSafeArea()
            
            switch recordManager.recordViewMode {
            case .menu:
                FinishMenuView(presented: $presented,
                               shouldPopToRoot: $shouldPopToRoot,
                               selectedProfile: $selectedProfile)
            case .teacherEdit:
                TeacherRegisterView()
            case .input:
                RegisterView(presented: $presented,
                             shouldPopToRoot: $shouldPopToRoot,
                             selectedProfile: selectedProfile)
            }
        }
        .frame(width: 1014, height: 660)
        .onAppear {   
            recordManager.recordViewMode = .menu
            //MARK: Ajustar acesso direto à propriedade
            recordManager.savingProfile = profileManager.selectedProfile!
        }
    }
    
    
}
