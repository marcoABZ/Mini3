//
//  SoundManager.swift
//  Mini3
//
//  Created by Pablo Penas on 03/12/21.
//

import AVFoundation

enum SoundTypes: String, CaseIterable {
    case theme = "tiruliru"
    case gameFinish = "mimimimimi"
    case puzzleMount = "ptu"
}

class SoundManager {
    static var instance = SoundManager()
    
    var audioPlayer: [AVAudioPlayer] = []
    
    private init() {
        // MARK: Load de sons
        for sound in SoundTypes.allCases {
            setSoundPlayer(sound: sound.rawValue, type: ".wav")
        }
    }
    
    func setSoundPlayer(sound: String, type: String) {
        if let path = Bundle.main.path(forResource: sound, ofType: type) {
            do {
                let audio = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                audioPlayer.append(audio)
//                audioPlayer?.prepareToPlay()
//                audioPlayer?.play()
            } catch {
                print("ERROR")
            }
        }
    }
    
    func stopMusic(sound: SoundTypes) {
        let index = SoundTypes.allCases.firstIndex(of: sound)!
        audioPlayer[index].stop()
    }
    
    func playMusic(sound: SoundTypes) {
        let index = SoundTypes.allCases.firstIndex(of: sound)!
        let audio = audioPlayer[index]
        
        if sound == .theme {
            // MARK: Loops infinitos
            audio.numberOfLoops = 100
        }
        
        audio.prepareToPlay()
        audio.play()
    }
}
