//
//  SoundFuction.swift
//  fianl_Game
//
//  Created by 陳奇松 on 2021/6/30.
//

import Foundation
import SwiftUI
import AVFoundation

extension AVPlayer{
    static var bgQueuePlayer = AVQueuePlayer()
    
    static var bgPlayerLooper: AVPlayerLooper!
    
    static func setupBgMusic() {
        guard let url = Bundle.main.url(forResource: "背景音樂", withExtension:"mp3")
        else {
            fatalError("Failed to find sound file.")
            
        }
        let item = AVPlayerItem(url: url)
        bgPlayerLooper = AVPlayerLooper(player: bgQueuePlayer, templateItem: item)
    }
    
}
