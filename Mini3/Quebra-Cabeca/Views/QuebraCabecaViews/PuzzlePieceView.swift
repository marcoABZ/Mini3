//
//  PuzzlePieceView.swift
//  Mini3
//
//  Created by Marco Zulian on 16/11/21.
//

import SwiftUI

struct PuzzlePieceView: View {
    @EnvironmentObject var selectedProfileManager: SelectedProfileManager
    @ObservedObject var puzzleManager: PuzzleManager
    @ObservedObject var piece: PuzzlePieceManager<UIImage>
    var preview: Bool = false
    let letters: [String] = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j",
                            "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u",
                            "v", "w", "x", "y", "z"]
    
    var body: some View {
            ZStack {
                Image(uiImage: piece.content)
                    .if(puzzleManager.settings.ordenacao != .none) { v in
                        v.ordered(
                            text: puzzleManager.settings.ordenacao == .number ? String(piece.index + 1) : letters[piece.index],
                            position: puzzleManager.settings.horizontalDivision == 1 ? .left : .down,
                            fontSize: getFontSize(),
                            backgoundColor: selectedProfileManager.getProfileColor())
                    }
            }
            .offset(CGSize(width: piece.currentDisplacement.width + piece.acumulatedDisplacement.width, height: piece.currentDisplacement.height + piece.acumulatedDisplacement.height))
            .zIndex(piece.acumulatedDisplacement == .zero || piece.isCorrect ? 0 : 1)
            .shadow(color: selectedProfileManager.getProfileColor(), radius: piece.isCorrect ? 10 : 0)
            .overlay(
                GeometryReader { geo in
                    Color.clear
                        .onAppear {
                            if !preview {
                                piece.setStartPosition(at: geo.frame(in: .global))
                            }
                        }
                }
            )
    }
    
    func getFontSize() -> CGFloat {
        var size = 24 - 2 * Int(puzzleManager.piecesCount / 20)
        
        if size < 12 {
            size = 12
        }
        
        return CGFloat(size)
    }
}

