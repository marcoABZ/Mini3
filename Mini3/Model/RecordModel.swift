//
//  RecordModel.swift
//  Mini3
//
//  Created by Pablo Penas on 19/11/21.
//

import Foundation

enum Satisfaction {
    case notSatisfied
    case satisfied
    case overSatisfied
}

struct RecordModel {
    var satisfaction: Satisfaction
    var annotation: String
    var teacher: Teacher
    var game: Game
    
    init() {
        self.satisfaction = .notSatisfied
        self.annotation = ""
        self.teacher = Teacher(nome: "")
        self.game = .quebraCabeca
    }
}
