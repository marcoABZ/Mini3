//
//  Puzzle.swift
//  Mini3
//
//  Created by Marco Zulian on 11/11/21.
//

import Foundation
import SwiftUI

struct Puzzle<Element> {
    var pieces: [PuzzlePiece_<Element>]
    
    func isDone() -> Bool {
        pieces.allSatisfy { $0.isCorrect }
    }
}

class PuzzlePiece_<Element>: ObservableObject {
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

class PuzzleManager: ObservableObject {
    var settings: MemoryGameConfiguration {
        didSet {
            let pieces = settings.image.slice(verticalPieces: settings.verticalDivision, horizontalPieces: settings.horizontalDivision)
            let puzzlePieces = (0..<pieces.count).map { PuzzlePiece_<UIImage>(content: pieces[$0], index: $0) }
            
            self.puzzle = Puzzle<UIImage>(pieces: puzzlePieces)
            self.shuffledPieces = getShuffledPieces()
        }
    }
    
    @Published var puzzle: Puzzle<UIImage>
    private(set) var shuffledPieces: [(piece: PuzzlePiece_<UIImage>, i: Int)] = []
    var pieces: [PuzzlePiece_<UIImage>] { puzzle.pieces }

    var piecesCount: Int {
        puzzle.pieces.count
    }
    
    @Published var isOver: Bool = false
    
    init(settings: MemoryGameConfiguration) {
        self.settings = settings
        
        let pieces = settings.image.slice(verticalPieces: settings.verticalDivision, horizontalPieces: settings.horizontalDivision)
        let puzzlePieces = (0..<pieces.count).map { PuzzlePiece_<UIImage>(content: pieces[$0], index: $0) }
        
        self.puzzle = Puzzle<UIImage>(pieces: puzzlePieces)
        self.shuffledPieces = getShuffledPieces()
    }
    
    func getImageForPiece(atIndex i: Int) -> UIImage {
        return pieces[i].content
    }
    
    private func getPiecesPositions() -> [Int] {
        Array(0..<piecesCount).shuffled()
    }
    
    private func getShuffledPieces() -> [(piece: PuzzlePiece_<UIImage>, i: Int)] {
        let shuffledPositions = getPiecesPositions()
        var shuffledPieces: [(PuzzlePiece_<UIImage>, Int)] = []
        
        for i in shuffledPositions {
            shuffledPieces.append((pieces[i], i+1))
        }
        
        return shuffledPieces
    }
    
    func updateGameStatus() {
        isOver = puzzle.isDone()
    }
}
