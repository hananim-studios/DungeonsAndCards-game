//
//  Track.swift
//  DungeonsAndCards
//
//  Created by Gabriela de Carvalho Barros Bezerra on 14/12/16.
//  Copyright © 2016 hananim. All rights reserved.
//

import Foundation
import AVFoundation

class Track {
    
    let fileName: String
    var avAudioPlayer: AVAudioPlayer = AVAudioPlayer()
    
    init(fileNamed: String){
        
        self.fileName = fileNamed
        
        do {
            
            let URL: URL = Bundle.main.url(forResource: fileNamed, withExtension: "mp3")!
            try self.avAudioPlayer = AVAudioPlayer(contentsOf: URL)
            
        } catch {
            
            fatalError("Invalid URL, AVAudioPlayer not initialized")
        
        }
        
    }
    
}
