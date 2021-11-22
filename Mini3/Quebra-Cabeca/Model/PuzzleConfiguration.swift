//
//  PuzzleConfiguration.swift
//  Mini3
//
//  Created by Marco Zulian on 16/11/21.
//

import SwiftUI

class PuzzleConfiguration: ObservableObject {
    
    @Published var verticalDivision: Int = 1
    @Published var horizontalDivision: Int = 3
    @Published var som: Bool = false
    @Published var ordenacao: Ordenacao = .none
    @Published var image: UIImage = UIImage(named: "placeholder")!
    @Published var voltarPeca: Bool = false
    
    init(verticalDivision: Int = 1, horizontalDivision: Int = 3, som: Bool = false, ordenacao: Ordenacao = .none, image: UIImage = UIImage(named: "placeholder")!, voltarPeca: Bool = false) {
        self.verticalDivision = verticalDivision
        self.horizontalDivision = horizontalDivision
        self.som = som
        self.ordenacao = ordenacao
        self.image = image
        self.voltarPeca = voltarPeca
    }
    
    func setImage(_ im: UIImage) {
        image = im
    }
    
    enum Ordenacao {
        case none
        case letter
        case number
    }
}
