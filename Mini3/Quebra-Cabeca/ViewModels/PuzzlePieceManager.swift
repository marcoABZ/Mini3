//
//  PuzzlePieceManager.swift
//  Mini3
//
//  Created by Marco Zulian on 16/11/21.
//

import SwiftUI

class PuzzlePieceManager<Element>: ObservableObject {
    let content: Element
    let index: Int
    @Published var originalPosition: CGRect?
    @Published var displacement: CGSize = .zero
    var targetPosition: CGRect?
    @Published var isCorrect: Bool = false
    
    init(content: Element, index: Int) {
        self.content = content
        self.index = index
    }
    
    func setGoalPosition(at position: CGRect) {
        targetPosition = position
    }
    
    func setStartPosition(at position: CGRect) {
        originalPosition = position
    }
    
    func drag(forDistance distance: CGSize) {
        displacement = distance
    }
    
    func drop() {
        guard let tp = targetPosition,
              let op = originalPosition
        else { return }
        
        let dropPos = CGPoint(x: op.midX + displacement.width, y: op.midY + displacement.height)
        
        if tp.contains(dropPos) {
            isCorrect = true
            displacement = CGSize(width: tp.minX - op.minX, height: tp.minY - op.minY)
        } else {
            displacement = .zero
        }
    
    }
    
}
