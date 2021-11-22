//
//  QuebraCabecaProgressView.swift
//  Mini3
//
//  Created by Marco Zulian on 19/11/21.
//

import SwiftUI

struct QuebraCabecaProgressView: View {
    @ObservedObject var puzzleManager: PuzzleManager
    
    var body: some View {
        HStack {
            ForEach(puzzleManager.pieces, id: \.index) {piece in
                Image(systemName: piece.isCorrect ? "star.fill" : "circlebadge.fill")
                    .foregroundColor(piece.isCorrect ? .yellow : Color(uiColor: .systemGray2))
                    .font(.system(size: 18, weight: .regular, design: .default))
                    .frame(width: 20, height: 20)
            }
        }
        .padding()
        .background(
            Capsule()
                .foregroundColor(.white)
                .shadow(color: .gray, radius: 10, x: 0, y: 4)
        )
        .offset(x: 0, y: -30)
    }
}
