//
//  PlaySoundMethod.swift
//  Mini3
//
//  Created by Marco Zulian on 22/11/21.
//

import AVFoundation

func createSoundPlayer(sound: String, type: String) -> AVAudioPlayer? {
    var audioPlayer: AVAudioPlayer?
    
    if let path = Bundle.main.path(forResource: sound, ofType: type) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.play()
        } catch {
            print("ERROR")
        }
    }
    
    return audioPlayer
}
