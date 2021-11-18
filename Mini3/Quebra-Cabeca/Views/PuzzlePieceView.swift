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
    
    var body: some View {
            ZStack {
                if puzzleManager.settings.ordenacao {
                    Image(uiImage: piece.content)
                        .overlay (alignment: .bottom) {
//                            Rectangle()
//                                .foregroundColor(student.getProfileColor())
//                                .frame(height: 50)
//                                .opacity(piece.isCorrect ? 0.7 : 1)
                            Text(String(piece.index + 1))
                                .foregroundColor(.white)
                                .font(.system(size: 28, weight: .bold, design: .default))
                                .frame(width: piece.content.size.width)
                                .padding(.vertical)
                                .background(student.getProfileColor())

                        }
                } else {
                    Image(uiImage: piece.content)
                }
            }
            .offset(piece.displacement)
            .zIndex(piece.displacement == .zero ? 0 : 1)
            .gesture(
                DragGesture(coordinateSpace: .global)
                    .onChanged {
                        if !piece.isCorrect {
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
}

