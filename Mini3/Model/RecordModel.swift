//
//  RecordModel.swift
//  Mini3
//
//  Created by Pablo Penas on 19/11/21.
//

import Foundation

enum Satisfaction: Int16, CaseIterable {
    case overSatisfied
    case satisfied
    case notSatisfied
}

struct RecordModel: Hashable {
    var satisfaction: Satisfaction
    var annotation: String
    var teacher: Teacher
    var game: Game
    var dateSaved: Date
    var studentId: UUID
    
    var id = UUID()
    
    init(satisfaction: Satisfaction, annotation: String, teacher: Teacher, game: Game, dateSaved: Date, studentId: UUID, id: UUID) {
        self.satisfaction = satisfaction
        self.annotation = annotation
        self.teacher = teacher
        self.game = game
        self.dateSaved = dateSaved
        self.studentId = studentId
        self.id = id
    }
    
    init() {
        self.satisfaction = .satisfied
        self.annotation = ""
        self.teacher = Teacher(nome: "")
        self.game = .quebraCabeca
        self.dateSaved = Date()
        self.studentId = UUID()
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
