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
        self.image = getRandomCoverImage().resizeImageTo(size: CGSize(width: 362, height: 476))!
        self.voltarPeca = voltarPeca
    }
    
    func setImage(_ im: UIImage) {
        image = im
    }
    
    enum Ordenacao: String, CaseIterable, Identifiable {
        var id: Self { self }
        
        case none = "X"
        case letter = "A"
        case number = "1"
    }
    
    func getRandomCoverImage() -> UIImage {
        let game = Game.allCases.randomElement()!
        let mascote = Mascotes.allCases.randomElement()!
        let cover = game.getCoverImage(mascote: mascote)
        return UIImage(named: cover)!
    }
}

