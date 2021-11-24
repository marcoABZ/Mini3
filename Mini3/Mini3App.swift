//
//  Mini3App.swift
//  Mini3
//
//  Created by Marco Zulian on 05/11/21.
//

import SwiftUI

@main
struct Mini3App: App {
    
    @ObservedObject var profileManager: ProfileManager = ProfileManager()
    
    var body: some Scene {
        WindowGroup {
            SplashView()
                .environmentObject(profileManager)
                .environmentObject(DashboardManager())
                .environmentObject(RecordManager())
                .environment(\.colorScheme, profileManager.selectedProfile?.darkModeEnabled ?? false ? .dark : .light)
                .accentColor(.primary)
        }
    }
}
