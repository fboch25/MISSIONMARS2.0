//
//  StartScreen.swift
//  MISSIONMARS2
//
//  Created by Frank Joseph Boccia on 3/8/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

import Foundation
import AVFoundation
import GameKit
import AudioToolbox 

class StartScreen: CCScene {
    
    weak var gamePhysicsNode: CCPhysicsNode!
    let audio = OALSimpleAudio.sharedInstance()
    
    func didLoadFromCCB(){
        setUpGameCenter()
        userInteractionEnabled = true
        //audio.playBg("Mission Mars Soundtrack.wav", loop: true)
    }
    func play(){
        let scene = CCBReader.loadAsScene("MainScene")
        CCDirector.sharedDirector().presentScene(scene)
    }
    func setUpGameCenter(){
        let gameCenterInteractor = GameCenterInteractor.sharedInstance
        gameCenterInteractor.authenticationCheck()
        
    }
    
}