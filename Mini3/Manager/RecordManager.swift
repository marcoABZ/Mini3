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
    
    @Published var currentGame: Game = .quebraCabeca
    
    @Published var selectedRecordId: UUID
    
    @Published var detailSheetShowing: Bool
    
    @Published var savingProfile: ProfileModel
    
    
    init() {
        self.registeredTeachers = []
        self.addingTeacher = ""
        self.editingRecord = RecordModel()
        self.recordViewMode = .menu
        self.selectedTeacher = Teacher(nome: "")
        
        self.selectedRecordId = UUID()
        self.detailSheetShowing = false
        self.savingProfile = ProfileModel(name: "", birthdate: Date(), color: .clear, image: "")
        
        // Dados de teste
        self.registeredTeachers.append(Teacher(nome: "Teste 1"))
        self.registeredTeachers.append(Teacher(nome: "Teste 2"))
        self.registeredTeachers.append(Teacher(nome: "Teste 3"))
        self.registeredTeachers.append(Teacher(nome: "Teste 4"))
        
        self.registeredRecords.append(RecordModel())
        self.registeredRecords.append(RecordModel())
        self.registeredRecords.append(RecordModel())
        self.registeredRecords[0].teacher = registeredTeachers[0]
        self.registeredRecords[1].teacher = registeredTeachers[1]
        self.registeredRecords[2].teacher = registeredTeachers[2]
        self.registeredRecords[0].satisfaction = .notSatisfied
        self.registeredRecords[1].satisfaction = .satisfied
        self.registeredRecords[2].satisfaction = .overSatisfied
        self.registeredRecords[0].game = .quebraCabeca
        self.registeredRecords[1].game = .quebraCabeca
        self.registeredRecords[2].game = .formas
        self.registeredRecords[0].annotation = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Nullam non nisi est sit amet facilisis magna. Vitae elementum curabitur vitae nunc sed velit dignissim. A cras semper auctor neque vitae. Pulvinar mattis nunc sed blandit libero. Dictum varius duis at consectetur lorem donec massa sapien faucibus. Eu turpis egestas pretium aenean pharetra. Donec ac odio tempor orci dapibus ultrices in iaculis. Magna sit amet purus gravida quis blandit turpis cursus. Sapien et ligula ullamcorper malesuada proin libero nunc. Ullamcorper malesuada proin libero nunc consequat. Velit laoreet id donec ultrices tincidunt arcu non."
        
        self.selectedTeacher = registeredTeachers[0]
        //
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
        addingTeacher = ""
    }
    
    func editTeacher() {
        recordViewMode = .teacherEdit
    }
    
    func eraseTeacher(teacher: Teacher) {
        registeredTeachers = registeredTeachers.filter { $0 != teacher }
    }
    
    func saveRecord(student: ProfileModel) {
        editingRecord.teacher = selectedTeacher
        editingRecord.dateSaved = Date()
        editingRecord.game = currentGame
        editingRecord.student = student
        registeredRecords.append(editingRecord)
        editingRecord = RecordModel()
    }
    
    func eraseRecord(record: RecordModel) {
        registeredRecords.remove(at: registeredRecords.firstIndex(of: record)!)
    }
    
    func getSatisfactionRates(jogo: Game) -> [Float] {
        if registeredRecords.filter({$0.game == jogo}).isEmpty {
            return [0,0,0]
        } else {
            let gameRecords = registeredRecords.filter { $0.game == jogo }
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
    
    func checkRecordsSaved(game: Game) -> Bool {
        let check = registeredRecords.filter { $0.game == game }
        return check.count == 0
    }
    
    func getLastRecordTeacher(game: Game) -> String? {
        let gameRecords = registeredRecords.filter { $0.game == game }
        
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
    
    func getLastRecordDate(game: Game) -> String? {
        let gameRecords = registeredRecords.filter { $0.game == game }
        
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
    
    func getRecordByGame(game: Game) -> [RecordModel] {
        let result = registeredRecords.filter { $0.game == game }
        return result
    }
    
    func getRecordIndex(record: RecordModel) -> Int {
        let records = getRecordByGame(game: currentGame)
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
