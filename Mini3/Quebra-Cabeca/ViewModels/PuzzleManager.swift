//
//  PuzzleManage.swift
//  Mini3
//
//  Created by Marco Zulian on 16/11/21.
//

import SwiftUI

class PuzzleManager: ObservableObject {
    var settings: PuzzleConfiguration {
        didSet {
            let pieces = settings.image.slice(verticalPieces: settings.verticalDivision, horizontalPieces: settings.horizontalDivision)
            let puzzlePieces = (0..<pieces.count).map { PuzzlePieceManager<UIImage>(content: pieces[$0], index: $0) }
            
            self.puzzle = Puzzle<UIImage>(pieces: puzzlePieces)
            self.shuffledPieces = getShuffledPieces()
        }
    }
    
    @Published var puzzle: Puzzle<UIImage>
    private(set) var shuffledPieces: [(piece: PuzzlePieceManager<UIImage>, i: Int)] = []
    var pieces: [PuzzlePieceManager<UIImage>] { puzzle.pieces }

    var piecesCount: Int {
        puzzle.pieces.count
    }
    
    @Published var isOver: Bool = false
    
    init(settings: PuzzleConfiguration) {
        self.settings = settings
        
        let pieces = settings.image.slice(verticalPieces: settings.verticalDivision, horizontalPieces: settings.horizontalDivision)
        let puzzlePieces = (0..<pieces.count).map { PuzzlePieceManager<UIImage>(content: pieces[$0], index: $0, shouldMoveBack: settings.voltarPeca, shouldPlaySound: settings.som) }
        
        self.puzzle = Puzzle<UIImage>(pieces: puzzlePieces)
        self.shuffledPieces = getShuffledPieces()
    }
    
    func getImageForPiece(atIndex i: Int) -> UIImage {
        return pieces[i].content
    }
    
    private func getPiecesPositions() -> [Int] {
        Array(0..<piecesCount).shuffled()
    }
    
    private func getShuffledPieces() -> [(piece: PuzzlePieceManager<UIImage>, i: Int)] {
        let shuffledPositions = getPiecesPositions()
        var shuffledPieces: [(PuzzlePieceManager<UIImage>, Int)] = []
        
        for i in shuffledPositions {
            shuffledPieces.append((pieces[i], i+1))
        }
        
        return shuffledPieces
    }
    
    func updateGameStatus() {
        isOver = puzzle.isDone()
    }
}
