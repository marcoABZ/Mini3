//
//  Mini3App.swift
//  Mini3
//
//  Created by Marco Zulian on 05/11/21.
//

import SwiftUI

@main
struct Mini3App: App {
    
    @StateObject var profileManager: ProfileManager = ProfileManager()
    @StateObject var recordManager = RecordManager()
    @StateObject var dashboardManager = DashboardManager()
    
    
    var body: some Scene {
        WindowGroup {
            SplashView()
                .environmentObject(profileManager)
                .environmentObject(recordManager)
                .environmentObject(dashboardManager)
                .accentColor(.primary)
//                .environmentObject(dashboardManager)
        }
    }
}
