//
//  GameFinishView.swift
//  Mini3
//
//  Created by Pablo Penas on 17/11/21.
//

import SwiftUI

struct BackgroundView: View {
    @EnvironmentObject var selectedProfilemanager: SelectedProfileManager
    var body: some View {
        selectedProfilemanager.getProfileColor()
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(.white.opacity(0.3), lineWidth: 5)
            )
            .ignoresSafeArea()
    }
}

struct GameFinishView: View {
    @EnvironmentObject var selectedProfilemanager: SelectedProfileManager
    @EnvironmentObject var profileManager: ProfileManager
    @EnvironmentObject var recordManager: RecordManager
    @Binding var presented: Bool
    @Binding var shouldPopToRoot: Bool
    @State var selectedProfile: ProfileModel
    
    var body: some View {
        ZStack {
            switch recordManager.recordViewMode {
            case .menu:
                ZStack {
                    BackgroundView()
                    FinishMenuView(presented: $presented,
                                   shouldPopToRoot: $shouldPopToRoot,
                                   selectedProfile: selectedProfilemanager.getID())
                }
                .transition(.scale)
            case .teacherEdit:
                ZStack {
                    BackgroundView()
                    TeacherRegisterView()
                }
                .transition(.slide)
            case .input:
                ZStack {
                    BackgroundView()
                    RegisterView(presented: $presented,
                                 shouldPopToRoot: $shouldPopToRoot,
                                 selectedProfile: selectedProfilemanager.getProfile())
                }
                .transition(.opacity)
            }
                
        }
        .frame(width: 1014, height: 660)
        .onAppear {   
            recordManager.recordViewMode = .menu
            recordManager.savingProfile = selectedProfilemanager.getProfile()
        }
        .onDisappear { SoundManager.instance.playMusic(sound: .theme) }
    }
    
    
}
