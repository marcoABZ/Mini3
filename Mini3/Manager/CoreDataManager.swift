//
//  CoreDataManager.swift
//  Mini3
//
//  Created by Marco Zulian on 14/12/21.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    
    static var shared = CoreDataManager()
    
    let persistentContainter: NSPersistentContainer
    
    private init() {
        persistentContainter = NSPersistentContainer(name: "Mini3DataModel")
        persistentContainter.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Core Data Store failed \(error.localizedDescription)")
            }
            
        }
    }
    
    func deleteProfile(profile: ProfileModel) {
        
        let fetchRequest: NSFetchRequest<Profile> = Profile.fetchRequest()
        
        do {
            let profiles = try persistentContainter.viewContext.fetch(fetchRequest)
            let deletingProfile = profiles.first { $0.id == profile.id }!
            persistentContainter.viewContext.delete(deletingProfile)
            try persistentContainter.viewContext.save()
        } catch {
            persistentContainter.viewContext.rollback()
            print("Failed to save context \(error)")
        }
    }
    
    func deleteTeacher(teacher: Teacher) {
        
        let fetchRequest: NSFetchRequest<TeacherModel> = TeacherModel.fetchRequest()
        
        do {
            let teachers = try persistentContainter.viewContext.fetch(fetchRequest)
            let deletingProfile = teachers.first { $0.name == teacher.nome }!
            persistentContainter.viewContext.delete(deletingProfile)
            try persistentContainter.viewContext.save()
        } catch {
            persistentContainter.viewContext.rollback()
            print("Failed to save context \(error)")
        }
        
    }
    
    func deleteRecord(record: RecordModel) {
        
        let fetchRequest: NSFetchRequest<Record> = Record.fetchRequest()
        
        do {
            let records = try persistentContainter.viewContext.fetch(fetchRequest)
            let deletingRecord = records.first { $0.id == record.id }!
            persistentContainter.viewContext.delete(deletingRecord)
            try persistentContainter.viewContext.save()
        } catch {
            persistentContainter.viewContext.rollback()
            print("Failed to save context \(error)")
        }
        
    }
    
    func getAllProfiles() -> [ProfileModel] {
        
        let fetchRequest: NSFetchRequest<Profile> = Profile.fetchRequest()
        
        do {
           let profiles = try persistentContainter.viewContext.fetch(fetchRequest)
            
            return profiles.map {
                ProfileModel(name: $0.name!, birthdate: $0.birthdate!, color: $0.selectedColor as! UIColor, image: UIImage(data: $0.image!)!.resizeImageTo(size: CGSize(width: 110, height: 110))!, mascote: Mascotes(rawValue: $0.mascote)!, id: $0.id!, darkModeEnabled: $0.darkModeEnabled)
            }
            
        } catch {
            return []
        }
        
    }
    
    func getAllRecords() -> [RecordModel] {
        
        let fetchRequest: NSFetchRequest<Record> = Record.fetchRequest()
        
        do {
           let records = try persistentContainter.viewContext.fetch(fetchRequest)
            
            return records.map { RecordModel(satisfaction: Satisfaction(rawValue: $0.satisfaction)!, annotation: $0.annotation!, teacher: Teacher(nome: $0.teacher!), game: Game(rawValue: $0.game!)!, dateSaved: $0.dateSaved!, studentId: $0.studentId!, id: $0.id!) }
            
        } catch {
            return []
        }
        
    }
    
    func getAllTeachers() -> [Teacher] {
        
        let fetchRequest: NSFetchRequest<TeacherModel> = TeacherModel.fetchRequest()
        
        do {
           let teachers = try persistentContainter.viewContext.fetch(fetchRequest)
            
            return teachers.map { Teacher(nome: $0.name!) }
            
        } catch {
            return []
        }
        
    }
    
    func save(profile: ProfileModel) {
        
        let savingProfile = Profile(context: persistentContainter.viewContext)
        
        savingProfile.name = profile.name
        savingProfile.birthdate = profile.birthdate
        savingProfile.id = profile.id
        savingProfile.darkModeEnabled = profile.darkModeEnabled
        savingProfile.mascote = profile.mascote.rawValue
        savingProfile.image = profile.image.jpegData(compressionQuality: 1.0)
        savingProfile.selectedColor = profile.selectedColor
        
        do {
            try persistentContainter.viewContext.save()
        } catch {
            print("Failed to save profile \(error)")
        }
        
    }
    
    func save(teacher: Teacher) {
        
        let savingTeacher = TeacherModel(context: persistentContainter.viewContext)
        
        savingTeacher.name = teacher.nome
        
        do {
            try persistentContainter.viewContext.save()
        } catch {
            print("Failed to save teacher \(error)")
        }
    }
    
    func save(record: RecordModel) {
        
        let savingRecord = Record(context: persistentContainter.viewContext)
        
        savingRecord.satisfaction = record.satisfaction.rawValue
        savingRecord.annotation = record.annotation
        savingRecord.teacher = record.teacher.nome
        savingRecord.game = record.game.rawValue
        savingRecord.dateSaved = record.dateSaved
        savingRecord.studentId = record.studentId
        savingRecord.id = record.id
        
        do {
            try persistentContainter.viewContext.save()
        } catch {
            print("Failed to save record \(error)")
        }
    }
    
    func update(profile: ProfileModel) {
        
        let fetchRequest: NSFetchRequest<Profile> = Profile.fetchRequest()
        
        do {
            let profiles = try persistentContainter.viewContext.fetch(fetchRequest)
            let updatingProfile = profiles.first { $0.id == profile.id }!
            
            updatingProfile.name = profile.name
            updatingProfile.birthdate = profile.birthdate
            updatingProfile.id = profile.id
            updatingProfile.darkModeEnabled = profile.darkModeEnabled
            updatingProfile.mascote = profile.mascote.rawValue
            updatingProfile.image = profile.image.jpegData(compressionQuality: 1.0)
            updatingProfile.selectedColor = profile.selectedColor
            
            try persistentContainter.viewContext.save()
        } catch {
            persistentContainter.viewContext.rollback()
        }
    }
}
