//
//  Mini3App.swift
//  Mini3
//
//  Created by Marco Zulian on 05/11/21.
//

import SwiftUI

@main
struct Mini3App: App {
    var body: some Scene {
        WindowGroup {
            let cfg = MemoryGameConfiguration()
            let manager = PuzzleManager(settings: cfg)
            
            QuebraCabecaStartView(puzzleManager: manager)
                .environmentObject(Profile(teste: true))
        }
    }
}
