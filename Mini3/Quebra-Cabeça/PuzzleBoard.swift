//
//  PuzzleBoard.swift
//  Mini3
//
//  Created by Marco Zulian on 11/11/21.
//

import SwiftUI

struct PuzzleBoard: View {
    let horizontalDivisions: Int
    let verticalDivisions: Int

    var body: some View {
        GeometryReader { geometry in
            Path { path in
                let numberOfHorizontalGridLines = verticalDivisions
                let numberOfVerticalGridLines = horizontalDivisions
                let horizontalSpacing = geometry.size.width / CGFloat(horizontalDivisions)
                let verticalSpacing = geometry.size.height / CGFloat(verticalDivisions)
                for index in 0...numberOfVerticalGridLines {
                    let vOffset: CGFloat = CGFloat(index) * horizontalSpacing
                    path.move(to: CGPoint(x: vOffset, y: 0))
                    path.addLine(to: CGPoint(x: vOffset, y: geometry.size.height))
                }
                for index in 0...numberOfHorizontalGridLines {
                    let hOffset: CGFloat = CGFloat(index) * verticalSpacing
                    path.move(to: CGPoint(x: 0, y: hOffset))
                    path.addLine(to: CGPoint(x: geometry.size.width, y: hOffset))
                }
            }
            .stroke()

        }
    }
}

struct PuzzleBoard_Previews: PreviewProvider {
    static var previews: some View {
        PuzzleBoard(horizontalDivisions: 5, verticalDivisions: 2)
.previewInterfaceOrientation(.landscapeLeft)
    }
}

