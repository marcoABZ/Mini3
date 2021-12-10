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

protocol Dragable: AnyObject {
    var currentPosition: CGRect? { get set }
    var acumulatedDisplacement: CGSize { get set }
    var currentDisplacement: CGSize { get set }
    var targetPosition: CGRect? { get }
    var isCorrect: Bool { get set }
    var shouldMoveBack: Bool { get }
    var currentOffset: CGSize { get }
    
    func drag(forDistance distance: CGSize)
    func drop()
}

extension Dragable {
    var currentOffset: CGSize {
        get {
            CGSize(width: currentDisplacement.width + acumulatedDisplacement.width, height: currentDisplacement.height + acumulatedDisplacement.height)
        }
    }
    
    func drag(forDistance distance: CGSize) {
        currentDisplacement = distance
    }
    
    func drop() {
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
