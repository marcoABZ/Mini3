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

class RecordModel {
    var satisfaction: Satisfaction
    var annotation: String
    
    init() {
        self.satisfaction = .satisfied
        self.annotation = ""
    }
}
