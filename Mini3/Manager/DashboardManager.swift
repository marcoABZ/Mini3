//
//  DashboardManager.swift
//  Mini3
//
//  Created by Pablo Penas on 10/11/21.
//

import Foundation
import SwiftUI

enum ViewModes: String, CaseIterable {
    case games = "Jogos"
    case performance = "Desempenho"
}

class DashboardManager: ObservableObject {
    
    @Published var profileListShowing: Bool
    @Published var pickerSelection: ViewModes
    @Published var isSidebarOpen: Bool = false
    
    //Forçar update do picker
    @Published var renderView: Bool = false
    
    init() {
        self.profileListShowing = true
        self.pickerSelection = .games
    }
    
    static func getSplashViewSpacing(screenWidth: Int, itemsCount: Int) -> CGFloat {
        return CGFloat(screenWidth - 204 * (1 + itemsCount)) / 2
    }
}
