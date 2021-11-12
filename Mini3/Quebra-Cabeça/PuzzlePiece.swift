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
    let targetPos: CGRect
    @State var dragAmount = CGSize.zero
    @State var isCorrect: Bool = false
    @State var location: CGRect = .zero
    
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
                        if !isCorrect {
                            self.dragAmount = CGSize(width: $0.translation.width, height: $0.translation.height)
                        }
                        print(dragAmount)
                    }
                    .onEnded { _ in
                        let pos = CGPoint(x: location.midX + dragAmount.width, y: location.midY + dragAmount.height)
                        print("pos: \(pos)")
                        if targetPos.contains(pos) {
                            isCorrect = true
                            self.dragAmount = CGSize(width: targetPos.minX - location.minX, height: targetPos.minY - location.minY)
                        } else {
                            self.dragAmount = .zero
                        }
                    }
            )
            .shadow(color: color, radius: isCorrect ? 10 : 0)
            .overlay(
                GeometryReader { geo in
                    Color.clear
                        .onAppear {
                            location = geo.frame(in: .global)
                        }
                }
            )
    }
}

//struct PuzzlePiece_Previews: PreviewProvider {
//    static var previews: some View {
//        PuzzlePiece(color: .orange, image: Image("placeholder"), index: 1, ordered: true, targetPos: CGPoint(x: 0, y: 0), isCorrect: true)
//.previewInterfaceOrientation(.landscapeLeft)
//.environmentObject(Profile(teste: true))
//    }
//}

