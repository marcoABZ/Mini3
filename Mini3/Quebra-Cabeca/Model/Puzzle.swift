//
//  Puzzle.swift
//  Mini3
//
//  Created by Marco Zulian on 11/11/21.
//

import Foundation
import SwiftUI

struct Puzzle<Element> {
    var pieces: [PuzzlePieceManager<Element>]
    
    func isDone() -> Bool {
        pieces.allSatisfy { $0.isCorrect }
    }
}
