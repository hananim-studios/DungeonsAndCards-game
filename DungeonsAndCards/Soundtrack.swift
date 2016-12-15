//
//  Soundtrack.swift
//  DungeonsAndCards
//
//  Created by Gabriela de Carvalho Barros Bezerra on 14/12/16.
//  Copyright © 2016 hananim. All rights reserved.
//

import Foundation
import AVFoundation

class Soundtrack {
    
    public static var sharedInstance = Soundtrack()
    
    private var tracks: [Track] = []
    
    func setTracks(withNames names: [String]) {
        
        for name in names {
            let newTrack = Track(fileNamed: name)
            tracks.append(newTrack)
        }
        
    }
    
    func playAll(numberOfLoops: Int) {
        
        let now = self.tracks[0].avAudioPlayer.deviceCurrentTime
        
        for track in self.tracks {
            track.avAudioPlayer.numberOfLoops = numberOfLoops
            track.avAudioPlayer.play(atTime: now + 1)
        }
    }
    
    func muteAll() {
        
        for track in self.tracks {
            track.avAudioPlayer.volume = 0
        }
    }
    
    func disableTracks(named names: [String] , withFade fade: Bool) {
        
        names.forEach { name in
            self.tracks.filter {
                return name == $0.fileName
                }.forEach { track in
                    if fade {
                        DispatchQueue.main.async {
                            while (track.avAudioPlayer.volume > 0){
                                track.avAudioPlayer.volume -= 0.0001
                            }
                        }
                        
                    } else {
                        track.avAudioPlayer.volume = 0
                    }
                            
                    
            }
        }
        
    }
    
    
    func enableTracks(named names: [String], volume: Float, fade: Bool) {
        
        names.forEach { name in
            self.tracks.filter {
                return name == $0.fileName
                }.forEach { track in
                    if fade {
                        DispatchQueue.main.async {
                            while (track.avAudioPlayer.volume < volume){
                                track.avAudioPlayer.volume += 0.1
                                sleep(2)
                            }
                        }
                        
                    } else {
                        track.avAudioPlayer.volume = volume
                    }
            }
        }
        
    }
    
    
}















