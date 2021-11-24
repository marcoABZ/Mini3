//
//  PuzzleBoardView.swift
//  Mini3
//
//  Created by Marco Zulian on 16/11/21.
//

import SwiftUI

struct PuzzleBoardView: View {
    
    @EnvironmentObject var student: ProfileManager
    @ObservedObject var puzzleManager: PuzzleManager
    @State var showAnswer: Bool = false
    
    var body: some View {
        VStack {
            ZStack {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 0), count: puzzleManager.settings.horizontalDivision), spacing: 0) {
                    // TODO: Arrumar ordenação e setar ordenação com letras
                    ForEach(0..<puzzleManager.piecesCount) { i in
                        Image(uiImage: puzzleManager.getImageForPiece(atIndex: i))
                            .opacity(showAnswer ? 0.5 : 0)
                            .overlay(
                                GeometryReader { geo in
                                    Rectangle()
//                                        .stroke(Color(uiColor: .systemGray2))
                                        .stroke(student.getProfileColor())
                                        .onAppear {
                                            puzzleManager.pieces[i].setGoalPosition(at: geo.frame(in: .global))
                                        }
                                }
                            )
                    }
                }
                .frame(width: puzzleManager.settings.image.size.width, height: puzzleManager.settings.image.size.height)
            }
            Image(systemName: "eye")
                .font(.system(size: 24, weight: .bold, design: .default))
                .foregroundColor(.white)
                .padding()
                .background(
                    Capsule()
                        .foregroundColor(student.getProfileColor())
                )
                .gesture (
                    DragGesture(minimumDistance: 0)
                        .onChanged {_ in
                            showAnswer = true
                        }
                        .onEnded {_ in
                            showAnswer = false
                        }
                )
        }
    }
}
