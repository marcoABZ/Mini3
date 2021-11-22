//
//  PuzzlePieceManager.swift
//  Mini3
//
//  Created by Marco Zulian on 16/11/21.
//

import SwiftUI
import AVFAudio

class PuzzlePieceManager<Element>: ObservableObject {
    let content: Element
    let index: Int
    @Published var currentPosition: CGRect?
    @Published var acumulatedDisplacement: CGSize = .zero
    @Published var currentDisplacement: CGSize = .zero
    var targetPosition: CGRect?
    @Published var isCorrect: Bool = false
    var shouldMoveBack: Bool
    var shouldPlaySound: Bool
    var sound: AVAudioPlayer?
    
    init(content: Element, index: Int, shouldMoveBack: Bool = false, shouldPlaySound: Bool = false) {
        self.content = content
        self.index = index
        self.shouldMoveBack = shouldMoveBack
        self.sound = createSoundPlayer(sound: "ptu", type: "wav")
        self.shouldPlaySound = shouldPlaySound
    }
    
    func setGoalPosition(at position: CGRect) {
        targetPosition = position
    }
    
    func setStartPosition(at position: CGRect) {
        currentPosition = position
    }
    
    func drag(forDistance distance: CGSize) {
        currentDisplacement = distance
    }
    
    func drop() {
        guard let tp = targetPosition,
              let op = currentPosition
        else { return }
        
        let dropPos = CGPoint(x: op.midX + currentDisplacement.width + acumulatedDisplacement.width, y: op.midY + currentDisplacement.height + acumulatedDisplacement.height)
        
        if tp.contains(dropPos) {
            isCorrect = true
            currentDisplacement = CGSize(width: tp.minX - op.minX, height: tp.minY - op.minY)
            acumulatedDisplacement = .zero
            if shouldPlaySound {
                sound?.play()
            }
        } else {
            if shouldMoveBack {
                acumulatedDisplacement = .zero
            } else {
                acumulatedDisplacement = CGSize(width: acumulatedDisplacement.width + currentDisplacement.width, height: acumulatedDisplacement.height + currentDisplacement.height)
            }
            
            currentDisplacement = .zero
        }
    
    }
    
}
