//
//  SliceTest.swift
//  Mini3
//
//  Created by Marco Zulian on 11/11/21.
//

import SwiftUI
import AVFoundation

struct QuebraCabecaGameView: View {
    @EnvironmentObject var selectedProfileManager: SelectedProfileManager
    @StateObject var puzzleManager: PuzzleManager
    @Environment(\.presentationMode) var presentationMode
    @State var isGameOver: Bool? = false
    @State var sound: AVAudioPlayer?
    @State var presenting: Bool = false
    @Binding var presentingSettings: Bool
    @Binding var shouldPopToRoot: Bool

    var body: some View {
        ZStack {
            selectedProfileManager.getProfileColor()
                .ignoresSafeArea(.all)
            ZStack(alignment: .top) {
                HStack {
                    Spacer()
                    PuzzleBoardView(puzzleManager: puzzleManager)
                    Spacer()
                    Divider()
                        .background(selectedProfileManager.getProfileColor())
                    Spacer()
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 50), count: puzzleManager.settings.horizontalDivision)) {
                        // TODO: Setar ordenação com letras
                        ForEach(puzzleManager.shuffledPieces, id: \.i) { (piece, index) in
                            PuzzlePieceView(
                                puzzleManager: puzzleManager,
                                piece: piece)
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
        }
        .onChange(of: puzzleManager.isOver) {_ in
            presenting = true
            presentationMode.wrappedValue.dismiss()
            SoundManager.instance.playMusic(sound: .gameFinish)
        }
        .fullScreenCover(isPresented: $presenting) {
            GameFinishView(presented: $presenting,
                           shouldPopToRoot: $shouldPopToRoot,
                           selectedProfile: selectedProfileManager.getProfile()
//                           , presentingSettings: $presentingSettings
            )
                .padding(.horizontal, 90)
                .padding(.vertical, 80)
                .background(BackgroundBlurView())
                .ignoresSafeArea()
        }
        .onDisappear {
            puzzleManager.reset()
        }
        .onAppear {
            SoundManager.instance.stopMusic(sound: .theme)
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
