//
//  PuzzlePieceView.swift
//  Mini3
//
//  Created by Marco Zulian on 16/11/21.
//

import SwiftUI

struct PuzzlePieceView: View {
    @EnvironmentObject var student: ProfileManager
    @ObservedObject var puzzleManager: PuzzleManager
    @ObservedObject var piece: PuzzlePieceManager<UIImage>
    var preview: Bool = false
    let letters: [String] = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j",
                            "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u",
                            "v", "w", "x", "y", "z"]
    
    var body: some View {
            ZStack {
                if puzzleManager.settings.ordenacao != .none {
                    Image(uiImage: piece.content)
                        .overlay (alignment: puzzleManager.settings.horizontalDivision == 1 ? .leading : .bottom) {
//                            Rectangle()
//                                .foregroundColor(student.getProfileColor())
//                                .frame(height: 50)
//                                .opacity(piece.isCorrect ? 0.7 : 1)
                            Text(puzzleManager.settings.ordenacao == .number ? String(piece.index + 1) : letters[piece.index])
                                .foregroundColor(.white)
                                .font(.system(size: getFontSize(), weight: .bold, design: .default))
                                .padding(puzzleManager.settings.horizontalDivision == 1 ? .horizontal : .vertical, 2)
                                .if(puzzleManager.settings.horizontalDivision == 1) { v in
                                    v.frame(width: 50, height: piece.content.size.height)
                                }
                                .if(puzzleManager.settings.horizontalDivision != 1) { v in
                                    v.frame(width: piece.content.size.width)
                                }
                                .background(student.getProfileColor())

                        }
                } else {
                    Image(uiImage: piece.content)
                }
            }
            .offset(CGSize(width: piece.currentDisplacement.width + piece.acumulatedDisplacement.width, height: piece.currentDisplacement.height + piece.acumulatedDisplacement.height))
            .zIndex(piece.acumulatedDisplacement == .zero || piece.isCorrect ? 0 : 1)
            .gesture(
                DragGesture(coordinateSpace: .global)
                    .onChanged {
                        if !piece.isCorrect && !preview {
                            piece.drag(forDistance: CGSize(width: $0.translation.width, height: $0.translation.height))                      }
                    }
                    .onEnded { _ in
                        piece.drop()
                        puzzleManager.updateGameStatus()
                        print(puzzleManager.isOver)
                    }
            )
            .shadow(color: student.getProfileColor(), radius: piece.isCorrect ? 10 : 0)
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

