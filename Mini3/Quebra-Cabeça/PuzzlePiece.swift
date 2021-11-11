//
//  PuzzlePiece.swift
//  Mini3
//
//  Created by Marco Zulian on 11/11/21.
//

import SwiftUI

struct PuzzlePiece: View {
    let color: Color
    let image: Image
    let index: Int
    let ordered: Bool
    let targetPos: CGPoint
    @State var dragAmount = CGSize.zero
    @State var isCorrect: Bool = false
    
    var body: some View {
        ZStack {
            if ordered {
                image
                    .overlay (alignment: .bottom) {
                        Rectangle()
                            .foregroundColor(color)
                            .frame(height: 50)
                        Text(String(index))
                            .foregroundColor(.white)
                            .font(.system(size: 36, weight: .bold, design: .default))
                    }
            } else {
                image
            }
        }
        .offset(dragAmount)
        .zIndex(dragAmount == .zero ? 0 : 1)
        .gesture(
            DragGesture(coordinateSpace: .global)
                .onChanged {
                    self.dragAmount = CGSize(width: $0.translation.width, height: $0.translation.height)
                    print(dragAmount)
                }
                .onEnded { _ in
//                    let dist = pow(targetPos.x.distance(to: dragAmount.width), 2) + pow(targetPos.y.distance(to: dragAmount.height), 2)
//                    if sqrt(dist) < 5000 {
//                        print("close")
//                        dragAmount = CGSize(width: 100, height: 100)
//                    }
                    self.dragAmount = .zero
                }
        )
        .shadow(color: color, radius: isCorrect ? 10 : 0)
    }
}

struct PuzzlePiece_Previews: PreviewProvider {
    static var previews: some View {
        PuzzlePiece(color: .orange, image: Image("placeholder"), index: 1, ordered: true, targetPos: CGPoint(x: 0, y: 0), isCorrect: true)
.previewInterfaceOrientation(.landscapeLeft)
.environmentObject(Profile(teste: true))
    }
}

