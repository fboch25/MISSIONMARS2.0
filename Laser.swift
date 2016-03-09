//
//  Laser.swift
//  MISSIONMARS2
//
//  Created by Frank Joseph Boccia on 3/8/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

import Foundation

class Laser : CCSprite {
    
    func didLoadFromCCB () {
        
    }
    
    override func update (delta: CCTime) {
        
        if self.position.x > CCDirector.sharedDirector().viewSize().width {
            self.removeFromParent()
        }
        
    }
}