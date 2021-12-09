//
//  PuzzlePieceManager.swift
//  Mini3
//
//  Created by Marco Zulian on 16/11/21.
//

import SwiftUI
import AVFAudio

class PuzzlePieceManager<Element>: ObservableObject, Dragable {

    let content: Element
    let index: Int
    @Published var currentPosition: CGRect?
    @Published var acumulatedDisplacement: CGSize = .zero
    @Published var currentDisplacement: CGSize = .zero
    var targetPosition: CGRect?
    @Published var isCorrect: Bool = false
    var shouldMoveBack: Bool
    var shouldPlaySound: Bool
//    var sound: AVAudioPlayer?
    
    init(content: Element, index: Int, shouldMoveBack: Bool = false, shouldPlaySound: Bool = false) {
        self.content = content
        self.index = index
        self.shouldMoveBack = shouldMoveBack
//        self.sound = createSoundPlayer(sound: "ptu", type: "wav")
        self.shouldPlaySound = shouldPlaySound
    }
    
    func setGoalPosition(at position: CGRect) {
        targetPosition = position
    }
    
    func setStartPosition(at position: CGRect) {
        currentPosition = position
    }
    
}
