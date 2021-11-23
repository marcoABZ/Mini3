//
//  RecordManager.swift
//  Mini3
//
//  Created by Pablo Penas on 17/11/21.
//

import SwiftUI

struct Teacher: Hashable {
    let nome: String
    
    init(nome: String) {
        self.nome = nome
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(nome)
    }
}

enum GameFinishMode {
    case menu
    case teacherEdit
    case input
}

class RecordManager: ObservableObject {
    @Published var registeredTeachers: [Teacher]
    
    @Published var addingTeacher: String
    
    @Published var editingRecord: RecordModel
    
    @Published var recordViewMode: GameFinishMode
    
    @Published var selectedTeacher: Teacher
    
    @Published var registeredRecords: [RecordModel] = []
    
    
    init() {
        self.registeredTeachers = []
        self.addingTeacher = ""
        self.editingRecord = RecordModel()
        self.recordViewMode = .menu
        self.selectedTeacher = Teacher(nome: "")
        
        self.registeredTeachers.append(Teacher(nome: "Teste 1"))
        self.registeredTeachers.append(Teacher(nome: "Teste 2"))
//        self.registeredTeachers.append(Teacher(nome: "Teste 3"))
//        self.registeredTeachers.append(Teacher(nome: "Teste 4"))
        self.selectedTeacher = registeredTeachers[0]
    }
    
    func updateViewMode() {
        if recordViewMode == .menu {
            if registeredTeachers.count > 0 {
                recordViewMode = .input
            } else {
                recordViewMode = .teacherEdit
            }
        } else if recordViewMode == .teacherEdit {
            recordViewMode = .input
        }
    }
    
    func returnToView() {
        if recordViewMode == .teacherEdit && registeredTeachers.count > 0 {
            recordViewMode = .input
        } else {
            recordViewMode = .menu
        }
    }
    
    func registerTeacher() {
        selectedTeacher = Teacher(nome: addingTeacher)
        registeredTeachers.append(Teacher(nome: addingTeacher))
        updateViewMode()
    }
    
    func editTeacher() {
        recordViewMode = .teacherEdit
    }
    
    func eraseTeacher(teacher: Teacher) {
        registeredTeachers = registeredTeachers.filter { $0 != teacher }
    }
    
    func saveRecord() {
        editingRecord.teacher = selectedTeacher
        registeredRecords.append(editingRecord)
        
    }
}
