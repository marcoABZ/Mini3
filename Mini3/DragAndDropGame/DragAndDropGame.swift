//
//  DragAndDropGame.swift
//  Mini3
//
//  Created by Marco Zulian on 09/12/21.
//

import Foundation
import SwiftUI

struct DragAndDropGame<Piece: Dragable> {
    var pieces: [Piece]
    
    func isDone() -> Bool {
        pieces.allSatisfy { $0.isCorrect }
    }
}

struct PuzzlePiece: Dragable {
    var currentPosition: CGRect?
    var acumulatedDisplacement: CGSize = .zero
    var currentDisplacement: CGSize = .zero
    var targetPosition: CGRect?
    var isCorrect: Bool = false
    var shouldMoveBack: Bool
}

protocol Dragable {
    var currentPosition: CGRect? { get set }
    var acumulatedDisplacement: CGSize { get set }
    var currentDisplacement: CGSize { get set }
    var targetPosition: CGRect? { get }
    var isCorrect: Bool { get set }
    var shouldMoveBack: Bool { get }
    var currentOffset: CGSize { get }
    
    mutating func drag(forDistance distance: CGSize)
    mutating func drop()
}

extension Dragable {
    var currentOffset: CGSize {
        get {
            CGSize(width: currentDisplacement.width + acumulatedDisplacement.width, height: currentDisplacement.height + acumulatedDisplacement.height)
        }
    }
    
    mutating func drag(forDistance distance: CGSize) {
        currentDisplacement = distance
    }
    
    mutating func drop() {
        guard let tp = targetPosition,
              let op = currentPosition
        else { return }
        
        let dropPos = CGPoint(x: op.midX + currentDisplacement.width + acumulatedDisplacement.width, y: op.midY + currentDisplacement.height + acumulatedDisplacement.height)
        
        if tp.contains(dropPos) {
            isCorrect = true
            currentDisplacement = CGSize(width: tp.minX - op.minX, height: tp.minY - op.minY)
            acumulatedDisplacement = .zero
        } else {
            if shouldMoveBack {
                acumulatedDisplacement = .zero
            } else {
                acumulatedDisplacement = CGSize(width: acumulatedDisplacement.width + currentDisplacement.width, height: acumulatedDisplacement.height + currentDisplacement.height)
            }
            
            currentDisplacement = .zero
        }
    }
}

struct Ordered: ViewModifier {
    
    let text: String
    let position: LabelPosition
    let fontSize: CGFloat
    let backgroundColor: Color
    
    func body(content: Content) -> some View {
        content
            .overlay(alignment: position == .left ? .leading : .bottom) {
                Text(text)
                    .foregroundColor(.white)
                    .font(.system(size: fontSize, weight: .bold, design: .default))
                    .padding(position == .left ? .horizontal : .vertical, 2)
                    .if(position == .left) { v in
                        v.frame(minWidth: 50, maxHeight: .infinity)
                    }
                    .if(position == .down) { v in
                        v.frame(maxWidth: .infinity)
                    }
                    .background(backgroundColor)
            }
    }
}

extension View {
    func ordered(text: String, position: LabelPosition, fontSize: CGFloat, backgoundColor: Color) -> some View {
        self.modifier(Ordered(text: text, position: position, fontSize: fontSize, backgroundColor: backgoundColor))
    }
}

enum LabelPosition {
    case down
    case left
}
