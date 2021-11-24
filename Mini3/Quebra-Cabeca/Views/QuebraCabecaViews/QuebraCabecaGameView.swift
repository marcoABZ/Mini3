//
//  SliceTest.swift
//  Mini3
//
//  Created by Marco Zulian on 11/11/21.
//

import SwiftUI
import AVFoundation

struct QuebraCabecaGameView: View {
    @EnvironmentObject var student: ProfileManager
    @ObservedObject var puzzleManager: PuzzleManager
    @State var isGameOver: Bool? = false
    @State var sound: AVAudioPlayer?
    
    var body: some View {
        student.getProfileColor()
            .ignoresSafeArea(.all)
            .overlay {
                ZStack(alignment: .top) {
                    HStack {
                        Spacer()
                        PuzzleBoardView(puzzleManager: puzzleManager)
                        Spacer()
                        Divider()
                            .background(student.getProfileColor())
                        Spacer()
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 50), count: puzzleManager.settings.horizontalDivision)) {
                            // TODO: Setar ordenação com letras
                            ForEach(puzzleManager.shuffledPieces, id: \.i) { (piece, index) in
                                PuzzlePieceView(
                                    puzzleManager: puzzleManager,
                                    piece: piece)
                            }
                        }
                        Spacer()
                    }
                    .frame(width: settingsPlusImageWidth, height: settingsHeight)
                    .background()
                    .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .circular))
                    if (puzzleManager.piecesCount <= 35) {
                        QuebraCabecaProgressView(puzzleManager: puzzleManager)
                    }
                }
            }.fullScreenCover(isPresented: $puzzleManager.isOver) {
                GameFinishView()
                    .environmentObject(student)
                    .padding(.horizontal, 90)
                    .padding(.vertical, 80)
                    .background(BackgroundBlurView())
                    .ignoresSafeArea()
            }
    }

    //MARK: Constantes
    //TODO: Checar constantes, tentar deixá-las independentes do device
    let headerToSettingsSpacing: CGFloat = 10
    let settingsItemsSpacing: CGFloat = 30
    let settingsWidth: CGFloat = 506
    let settingsHeight: CGFloat = 621
    let cornerRadius: CGFloat = 32
    let settingsPlusImageWidth: CGFloat = 1012
}