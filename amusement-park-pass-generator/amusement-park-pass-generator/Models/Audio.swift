//
//  Audio.swift
//  amusement-park-pass-generator
//
//  Created by Elena Meneghini on 16/04/2019.
//  Copyright © 2019 Elena Meneghini. All rights reserved.
//

import Foundation
import AudioToolbox

class SoundEffectsPlayer {
    var sound: SystemSoundID = 0
    
    func playSound(for validation: AccessValidation) {
        let path = Bundle.main.path(forResource: validation.soundName(), ofType: "wav")!
        let soundURL = URL(fileURLWithPath: path) as CFURL
        
        AudioServicesCreateSystemSoundID(soundURL, &sound)
        AudioServicesPlaySystemSound(sound)
    }
}
