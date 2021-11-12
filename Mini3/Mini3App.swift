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
            SliceTest(horizontalPieces: 5, verticalPieces: 5)
                .environmentObject(Profile(teste: true))
        }
    }
}
