//
//  RecordManager.swift
//  Mini3
//
//  Created by Pablo Penas on 17/11/21.
//

import SwiftUI

struct Teacher {
    let nome: String
    
    init(nome: String) {
        self.nome = nome
    }
}

class RecordManager: ObservableObject {
    var registeredTeachers: [Teacher]
    
    @Published var addingTeacher: String
    
    @Published var editingRecord: RecordModel
    
    init() {
        self.registeredTeachers = []
        self.addingTeacher = ""
        self.editingRecord = RecordModel()
        
        self.registeredTeachers.append(Teacher(nome: "Prof. Silvana"))
        self.registeredTeachers.append(Teacher(nome: "Prof. Márcia"))
    }
}
