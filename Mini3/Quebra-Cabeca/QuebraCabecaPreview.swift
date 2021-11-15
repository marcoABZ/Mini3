//
//  QuebraCabecaPreview.swift
//  Mini3
//
//  Created by Marco Zulian on 15/11/21.
//

import SwiftUI


struct QuebraCabecaPreview: View {
    @EnvironmentObject var student: Profile
    @ObservedObject var settings: MemoryGameConfiguration
    
    private var slices: [UIImage] {
        if !settings.image.isEqual(UIImage(named: "placeholder")) {
            return settings.image.resizeImageTo(size: CGSize(width: 362, height: 476))!.slice(verticalPieces: settings.verticalDivision, horizontalPieces: settings.horizontalDivision)
        }
        else {
            return []
        }
    }
    
    var body: some View {
        if !slices.isEmpty {
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 35), count: settings.horizontalDivision)) {
            // TODO: Setar ordenação com letras
            ForEach(0..<slices.count, id: \.self) { i in
                PuzzlePiece(color: student.color, image: Image(uiImage: slices[i]), index: i + 1, ordered: settings.ordenacao, targetPos: CGRect())
            }
        }
        .frame(width: imageFrameWidth, height: imageFrameHeight)
            
        } else {
            Image(uiImage: settings.image)
                .resizable()
                .aspectRatio(imageAspectRatio, contentMode: .fit)
                .frame(width: imageFrameWidth, height: imageFrameHeight)
        }
    }
    
    //MARK: Constantes
    let imageAspectRatio: CGFloat = 3/4
    let imageFrameWidth: CGFloat = 362
    let imageFrameHeight: CGFloat = 476
}
