//
//  SliceTest.swift
//  Mini3
//
//  Created by Marco Zulian on 11/11/21.
//

import SwiftUI

struct SliceTest: View {
    @EnvironmentObject var student: Profile
    let horizontalPieces: Int
    let verticalPieces: Int
    let image: UIImage = UIImage(named: "placeholder1")!
    var slices: [UIImage] {
        image.slice(verticalPieces: verticalPieces, horizontalPieces: horizontalPieces)
    }
    
    var body: some View {
        let pieces = getPieces()
        student.color
            .ignoresSafeArea(.all)
            .overlay {
                HStack {
                    Spacer()
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 50), count: horizontalPieces)) {
                        // TODO: Arrumar ordenação e setar ordenação com letras
                        ForEach(0..<slices.count) { i in
                            PuzzlePiece(color: .orange, image: Image(uiImage: pieces[i]), index: i + 1, ordered: false, targetPos: CGPoint())
                        }
                    }
                    Spacer()
                    Divider()
                        .background(student.color)
                    Spacer()
                    PuzzleBoard(horizontalDivisions: horizontalPieces, verticalDivisions: verticalPieces)
                        .frame(width: image.size.width, height: image.size.height)
                        .zIndex(-1)
                    Spacer()
                }
                .frame(width: settingsPlusImageWidth, height: settingsHeight)
                .background()
                .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .circular))
            }
    }
    
    func getPieces() -> [UIImage] {
        var res = slices.shuffled()
        
        while res == slices {
            res.shuffle()
        }
        
        return res
    }
    
    func getTargetPos(forImage atIndex: Int) {
        
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
        SliceTest(horizontalPieces: 5, verticalPieces: 3)
            .previewInterfaceOrientation(.landscapeLeft)
            .environmentObject(Profile(teste: true))
    }
}
