//
//  RecordModel.swift
//  Mini3
//
//  Created by Pablo Penas on 19/11/21.
//

import Foundation

enum Satisfaction: CaseIterable {
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
    var student: ProfileModel
    
    var id = UUID()
    
    init() {
        self.satisfaction = .satisfied
        self.annotation = ""
        self.teacher = Teacher(nome: "")
        self.game = .quebraCabeca
        self.dateSaved = Date()
        self.student = ProfileModel(name: "", birthdate: Date(), color: .clear, image: "")
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
