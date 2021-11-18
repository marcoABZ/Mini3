//
//  PuzzleConfiguration.swift
//  Mini3
//
//  Created by Marco Zulian on 16/11/21.
//

import SwiftUI

class PuzzleConfiguration: Configuration, CustomStringConvertible, ObservableObject {
    
    @Published var verticalDivision: Int = 1
    @Published var horizontalDivision: Int = 3
    @Published var som: Bool = false
    @Published var animacao: Bool = false
    @Published var ordenacao: Bool = false
    @Published var tipoOrdenacao: Int = 0
    @Published var image: UIImage = UIImage(named: "placeholder")!
    @Published var voltarPeca: Bool = false
    
    init(verticalDivision: Int = 1, horizontalDivision: Int = 3, som: Bool = false, animacao: Bool = false, ordenacao: Bool = false, tipoOrdenacao: Int = 0, image: UIImage = UIImage(named: "placeholder")!, voltarPeca: Bool = false) {
        self.verticalDivision = verticalDivision
        self.horizontalDivision = horizontalDivision
        self.som = som
        self.animacao = animacao
        self.ordenacao = ordenacao
        self.tipoOrdenacao = tipoOrdenacao
        self.image = image
        self.voltarPeca = voltarPeca
    }
    
    func setImage(_ im: UIImage) {
        image = im
    }
    
    var description: String {
        """
        Vertical Divisions: \(verticalDivision)
        Horizontal Divisions: \(horizontalDivision)
        Image: \(image)
        """
    }
}
