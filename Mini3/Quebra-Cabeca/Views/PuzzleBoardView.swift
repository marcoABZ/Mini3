//
//  PuzzleBoardView.swift
//  Mini3
//
//  Created by Marco Zulian on 16/11/21.
//

import SwiftUI

struct PuzzleBoardView: View {
    
    @ObservedObject var puzzleManager: PuzzleManager
    
    var body: some View {
        ZStack {
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 0), count: puzzleManager.settings.horizontalDivision), spacing: 0) {
                // TODO: Arrumar ordenação e setar ordenação com letras
                ForEach(0..<puzzleManager.piecesCount) { i in
                    Image(uiImage: puzzleManager.getImageForPiece(atIndex: i))
                        .opacity(0)
                        .overlay(
                            GeometryReader { geo in
                                Rectangle()
                                    .stroke()
                                    .onAppear {
                                        puzzleManager.pieces[i].setGoalPosition(at: geo.frame(in: .global))
                                    }
                            }
                        )
                }.zIndex(-1)
            }
            .frame(width: puzzleManager.settings.image.size.width, height: puzzleManager.settings.image.size.height)
            .zIndex(-1)
        }
    }
}
