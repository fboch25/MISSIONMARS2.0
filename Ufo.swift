//
//  Ufo.swift
//  MISSIONMARS2
//
//  Created by Frank Joseph Boccia on 3/4/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

import Foundation

class Ufo: CCSprite {
    
    func Move(speed: CCTime) {
        let randX = arc4random_uniform(UInt32(CCDirector.sharedDirector().viewSize().width))
        let move = CCActionMoveTo(duration: speed, position: ccp(CGFloat(randX), 0))
        let disappear = CCActionCallBlock(block: {self.removeFromParent()})
        
        runAction(CCActionSequence(array: [move, disappear]))
        
    }
}