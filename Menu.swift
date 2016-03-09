//
//  Menu.swift
//  MISSIONMARS2
//
//  Created by Frank Joseph Boccia on 3/6/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

import Foundation
import AVFoundation
import GameKit

class Menu: CCScene {
    
    weak var gamePhysicsNode: CCPhysicsNode!
    
    func didLoadFromCCB(){
        setUpGameCenter()
        userInteractionEnabled = true
        
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