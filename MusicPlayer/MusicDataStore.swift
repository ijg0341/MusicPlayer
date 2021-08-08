//
//  MusicDataStore.swift
//  MusicPlayer
//
//  Created by Jingyu Lim on 2021/08/02.
//

import Foundation
import MediaPlayer

class MusicDataStore {
    
    static let shared = MusicDataStore()
    private init(){}
    
    var musicList: MPMediaItemCollection? = nil
    var seletedMusic: MPMediaItem? = nil

    
    var Player: MPMusicPlayerController? {
        get {
            let audioPlayer = MPMusicPlayerController.systemMusicPlayer
            audioPlayer.nowPlayingItem = seletedMusic
            return audioPlayer
        }
    }
    
    func getMusicItems() {
        let mediaItems = MPMediaQuery.songs().items
        if let mediaItems = mediaItems {
            let mediaCollection = MPMediaItemCollection(items: mediaItems)
            musicList = mediaCollection
        }
        
        
    }
}
