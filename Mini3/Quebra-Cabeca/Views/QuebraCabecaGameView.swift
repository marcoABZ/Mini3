//
//  SliceTest.swift
//  Mini3
//
//  Created by Marco Zulian on 11/11/21.
//

import SwiftUI

struct QuebraCabecaGameView: View {
    @EnvironmentObject var student: Profile
    @ObservedObject var puzzleManager: PuzzleManager
    @State var isGameOver: Bool? = false

    var body: some View {
        student.color
            .ignoresSafeArea(.all)
            .overlay {
                HStack {
                    Spacer()
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 50), count: puzzleManager.settings.horizontalDivision)) {
                        // TODO: Setar ordenação com letras
                        ForEach(puzzleManager.shuffledPieces, id: \.i) { (piece, index) in
                            PuzzlePieceView(puzzleManager: puzzleManager,
                                        piece: piece)
                        }
                    }
                    Spacer()
                    Divider()
                        .background(student.color)
                    Spacer()
                    PuzzleBoardView(puzzleManager: puzzleManager)
                    Spacer()
                }
                .frame(width: settingsPlusImageWidth, height: settingsHeight)
                .background()
                .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .circular))
            }.sheet(isPresented: $puzzleManager.isOver) {
                Image("fim-jogo-placeholder")
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

struct SliceTest_Previews: PreviewProvider {
    static var previews: some View {
        let student = Profile(teste: true)
        let cfg = PuzzleConfiguration(verticalDivision: 3, horizontalDivision: 3, som: false, animacao: true, ordenacao: true, tipoOrdenacao: 0, image: UIImage(named: "placeholder1")!)
        
        QuebraCabecaGameView(puzzleManager: PuzzleManager(settings: cfg))
            .previewInterfaceOrientation(.landscapeLeft)
            .environmentObject(student)
    }
}
