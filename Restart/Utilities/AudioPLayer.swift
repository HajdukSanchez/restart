//
//  AudioPlayer.swift
//  Restart
//
//  Created by Jozek Andrzej Hajduk Sanchez on 12/09/24.
//

import Foundation
import AVFoundation

var audioPlayer: AVAudioPlayer?

func playSound(sound: String, type: String) {
    if let path = Bundle.main.path(forResource: sound, ofType: type) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(filePath: path))
            audioPlayer?.play()
        } catch {
            print("Cloud not play the sound file.")
        }
    }
}
