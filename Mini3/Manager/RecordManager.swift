//
//  RecordManager.swift
//  Mini3
//
//  Created by Pablo Penas on 17/11/21.
//

import SwiftUI

struct Teacher: Hashable {
    let nome: String
    
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
    @Published var registeredRecords: [RecordModel]
    @Published var currentGame: Game = .quebraCabeca
    @Published var selectedRecordId: UUID
    @Published var detailSheetShowing: Bool
    @Published var savingProfile: ProfileModel
    
    init(registeredTeachers: [Teacher] = CoreDataManager.shared.getAllTeachers()) {
        self.registeredTeachers = registeredTeachers
        self.registeredRecords = CoreDataManager.shared.getAllRecords()
        self.addingTeacher = ""
        self.editingRecord = RecordModel()
        self.recordViewMode = .menu
        self.selectedTeacher = registeredTeachers.first ?? Teacher(nome: "")
        
        self.selectedRecordId = UUID()
        self.detailSheetShowing = false
        self.savingProfile = ProfileModel(name: "", birthdate: Date(), color: .clear, image: "")
    }
    
    func updateViewMode() {
        withAnimation(.easeIn) {
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
    }
    
    func returnToView() {
        withAnimation(.easeOut) {
            if recordViewMode == .teacherEdit && registeredTeachers.count > 0 {
                recordViewMode = .input
            } else {
                recordViewMode = .menu
            }
        }
    }
    
    func registerTeacher() {
        selectedTeacher = Teacher(nome: addingTeacher)
        registeredTeachers.append(Teacher(nome: addingTeacher))
        CoreDataManager.shared.save(teacher: Teacher(nome: addingTeacher))
        updateViewMode()
        addingTeacher = ""
    }
    
    func editTeacher() {
        withAnimation(.easeIn) {
            recordViewMode = .teacherEdit
        }
    }
    
    func eraseTeacher(teacher: Teacher) {
        registeredTeachers = registeredTeachers.filter { $0 != teacher }
        CoreDataManager.shared.deleteTeacher(teacher: teacher)
        let recordsToDelete = registeredRecords.filter { $0.teacher == teacher }
        registeredRecords = registeredRecords.filter { $0.teacher != teacher }
        for record in recordsToDelete {
            CoreDataManager.shared.deleteRecord(record: record)
        }
    }
    
    func saveRecord(student: ProfileModel) {
        editingRecord.teacher = selectedTeacher
        editingRecord.dateSaved = Date()
        editingRecord.game = currentGame
        editingRecord.studentId = student.id
        registeredRecords.append(editingRecord)
        CoreDataManager.shared.save(record: editingRecord)
        editingRecord = RecordModel()
        
    }
    
    func eraseRecord(record: RecordModel) {
        registeredRecords.remove(at: registeredRecords.firstIndex(of: record)!)
        CoreDataManager.shared.deleteRecord(record: record)
    }
    
    func eraseAllRecords(forStudent student: ProfileModel) {
        
        registeredRecords.removeAll { $0.studentId == student.id }
        
        let recordsToDelete = registeredRecords.filter { $0.studentId == student.id }
        for record in recordsToDelete {
            CoreDataManager.shared.deleteRecord(record: record)
        }
    }
    
    func getSatisfactionRates(jogo: Game, student: ProfileModel) -> [Float] {
        if registeredRecords.filter({$0.game == jogo && $0.studentId == student.id}).isEmpty {
            return [0,0,0]
        } else {
            let gameRecords = registeredRecords.filter { $0.game == jogo && $0.studentId == student.id }
            var satisfiedCount = 0
            var notSatisfiedCount = 0
            var overSatisfiedCount = 0
            for record in gameRecords {
                switch record.satisfaction {
                case.notSatisfied:
                    notSatisfiedCount += 1
                case .satisfied:
                    satisfiedCount += 1
                case .overSatisfied:
                    overSatisfiedCount += 1
                }
            }
            let notSatisfiedRate = Float(notSatisfiedCount) / Float(gameRecords.count)
            let satisfiedRate = Float(satisfiedCount) / Float(gameRecords.count)
            let overSatisfiedRate = Float(overSatisfiedCount) / Float(gameRecords.count)
            
            return [overSatisfiedRate,satisfiedRate,notSatisfiedRate]
        }
    }
    
    func checkRecordsSaved(game: Game, student: ProfileModel) -> Bool {
        let check = registeredRecords.filter { $0.game == game && $0.studentId == student.id }
        return check.count == 0
    }
    
    func getLastRecordTeacher(game: Game, student: ProfileModel) -> String? {
        let gameRecords = registeredRecords.filter { $0.game == game && $0.studentId == student.id }
        
        if gameRecords.isEmpty {
            return nil
        }
        var lastDate = Date(timeIntervalSince1970: 0)
        for record in gameRecords {
            if lastDate < record.dateSaved {
                lastDate = record.dateSaved
            }
        }
        
        
        let lastRecord = registeredRecords.filter {$0.dateSaved == lastDate}[0]
        
        return "Último registro: \(lastRecord.teacher.nome)"
    }
    
    func getLastRecordDate(game: Game, student: ProfileModel) -> String? {
        let gameRecords = registeredRecords.filter { $0.game == game && $0.studentId == student.id }
        
        if gameRecords.isEmpty {
            return nil
        }
        var lastDate = Date(timeIntervalSince1970: 0)
        for record in gameRecords {
            if lastDate < record.dateSaved {
                lastDate = record.dateSaved
            }
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/YY"
        
        return "Jogado em \(dateFormatter.string(from: lastDate))"
    }
    
    func getRecordByGame(game: Game, student: ProfileModel) -> [RecordModel] {
        let result = registeredRecords.filter { $0.game == game && $0.studentId == student.id }
        return result
    }
    
    func getRecordIndex(record: RecordModel, student: ProfileModel) -> Int {
        let records = getRecordByGame(game: currentGame, student: student)
        let index = records.firstIndex(of: record)!
        return index + 1
    }
    
    func dateToString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/YY"
        return dateFormatter.string(from: date)
    }
    
    func viewRecordDetail(game: Game) {
        detailSheetShowing = true
        currentGame = game
    }
}
