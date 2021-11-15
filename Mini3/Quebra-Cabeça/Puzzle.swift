//
//  Puzzle.swift
//  Mini3
//
//  Created by Marco Zulian on 11/11/21.
//

import Foundation
import SwiftUI

struct Puzzle<Element> {
    let pieces: [PuzzlePiece_<Element>]
    
    func isDone() -> Bool {
        pieces.allSatisfy { $0.isCorrect }
    }
}

struct PuzzlePiece_<Element> {
    let content: Element
    let index: Int
//    let originalPosition: CGRect
//    var displacement: CGSize = .zero
//    let targetPosition: CGRect
    var isCorrect: Bool = false
    
//    mutating func checkPiece(returnIfWrong: Bool) {
//        let pos = CGPoint(x: originalPosition.midX + displacement.width, y: originalPosition.midY + displacement.height)
//        print("pos: \(pos)")
//        if targetPosition.contains(pos) {
//            isCorrect = true
//            displacement = CGSize(width: targetPosition.minX - targetPosition.minX, height: targetPosition.minY - targetPosition.minY)
//        } else if returnIfWrong {
//            displacement = .zero
//        }
//    }
    
    mutating func dropPiece(atIndex index: Int) {
        isCorrect = (self.index == index)
    }
}

class PuzzleManager: ObservableObject {
    var settings: MemoryGameConfiguration {
        didSet {
            print("Setando")
            let pieces = settings.image.slice(verticalPieces: settings.verticalDivision, horizontalPieces: settings.horizontalDivision)
            let puzzlePieces = (0..<pieces.count).map { PuzzlePiece_<UIImage>(content: pieces[$0], index: $0) }
            
            self.puzzle = Puzzle<UIImage>(pieces: puzzlePieces)
            self.shuffledPieces = getShuffledPieces()
        }
    }
    
    @Published var puzzle: Puzzle<UIImage>
    private(set) var shuffledPieces: [(piece: PuzzlePiece_<UIImage>, i: Int)] = []
    var piecesCount: Int {
        puzzle.pieces.count
    }
    
    init(settings: MemoryGameConfiguration) {
        self.settings = settings
        
        let pieces = settings.image.slice(verticalPieces: settings.verticalDivision, horizontalPieces: settings.horizontalDivision)
        let puzzlePieces = (0..<pieces.count).map { PuzzlePiece_<UIImage>(content: pieces[$0], index: $0) }
        
        self.puzzle = Puzzle<UIImage>(pieces: puzzlePieces)
        self.shuffledPieces = getShuffledPieces()
    }
    
    func getPieces() -> [PuzzlePiece_<UIImage>] {
        return puzzle.pieces
    }
    
    func getImageForPiece(atIndex i: Int) -> UIImage {
        let pieces = getPieces()
        return pieces[i].content
    }
    
    private func getPiecesPositions() -> [Int] {
        Array(0..<piecesCount).shuffled()
    }
    
    private func getShuffledPieces() -> [(piece: PuzzlePiece_<UIImage>, i: Int)] {
        let shuffledPositions = getPiecesPositions()
        let pieces = getPieces()
        var shuffledPieces: [(PuzzlePiece_<UIImage>, Int)] = []
        
        for i in shuffledPositions {
            shuffledPieces.append((pieces[i], i+1))
        }
        
        return shuffledPieces
    }
    
}
