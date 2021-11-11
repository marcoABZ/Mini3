//
//  Puzzle.swift
//  Mini3
//
//  Created by Marco Zulian on 11/11/21.
//

import Foundation
import SwiftUI

struct Puzzle<Element> {
    let ordered: Bool
    let pieces: [(Element, Int)]
    
    func isDone() -> Bool {
        let expectedResult = pieces.sorted { $0.1 < $1.1 }
        
        for i in 0 ..< pieces.count {
            if pieces[i].1 != expectedResult[i].1 {
                return false
            }
        }
        return true
    }
}
