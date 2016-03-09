//
//  MainScene.swift
//  MISSIONMARS2
//
//  Created by Frank Joseph Boccia on 3/6/16.
//  Copyright (c) 2016 Apportable. All rights reserved.
//

import Foundation
import AVFoundation
import GameKit

class MainScene: CCNode, CCPhysicsCollisionDelegate {
    
    // Game Phyiscs Node
    weak var gamePhysicsNode: CCPhysicsNode!
    weak var gameEndScreen: GameEnd!
    weak var colorNode: CCNode!
    // Lasers

    // Ships
    weak var hero: Ship!
    weak var enemy: Ufo!
    weak var enemy2: Ufo!
    // Scoring Label
    weak var scoreLabel: CCLabelTTF!
    // touch/screen
    var currentTouchLocation: CGPoint!
    let screenSize = UIScreen.mainScreen().bounds
    var screenWidth = UIScreen.mainScreen().bounds.width
    var screenHeight = UIScreen.mainScreen().bounds.height
    // Gameover
    var gameOver: Bool = false
    // Defaults
    let defaults = NSUserDefaults.standardUserDefaults()
    
    var score: Int = 0 {
        didSet {
            scoreLabel.string = "\(score)"
        }
    }
    
    func didLoadFromCCB(){
        userInteractionEnabled = true
        gamePhysicsNode.collisionDelegate = self
        schedule("spawnUfo", interval: 0.8)
        schedule("spawnUfo2", interval: 3)
        
        
        if gameOver == false {
            gameEndScreen.visible = false
            
        }
    }
    
    // touches
    override func touchBegan(touch: CCTouch!, withEvent event: CCTouchEvent!) {
        currentTouchLocation = touch.locationInWorld()
        
    }
    override func touchMoved(touch: CCTouch!, withEvent event: CCTouchEvent!) {
        hero.position.x = CGFloat(clampf(Float(hero.position.x - (currentTouchLocation.x - touch.locationInWorld().x)),Float(0.0), Float(screenWidth)))
        currentTouchLocation = touch.locationInWorld()
    }
    
    // spawn enemy ufo
    func spawnUfo() {
        let enemy = CCBReader.load("ufo") as! Ufo
        enemy.zOrder += 1
        let x: CGFloat = CGFloat(arc4random_uniform(UInt32(CCDirector.sharedDirector().viewSize().width)))
        let y: CGFloat = CCDirector.sharedDirector().viewSize().height
        enemy.position.x = x
        enemy.position.y = 700
        gamePhysicsNode.addChild(enemy)
        enemy.Move(CCTime(3))
    }
    // spawn Red Ufo
    func spawnUfo2() {
        let enemy2 = CCBReader.load("ufo2") as! Ufo
        enemy2.zOrder += 1
        let x: CGFloat = CGFloat(arc4random_uniform(UInt32(CCDirector.sharedDirector().viewSize().width)))
        let y: CGFloat = CCDirector.sharedDirector().viewSize().height
        enemy2.position.x = x
        enemy2.position.y = 700
        gamePhysicsNode.addChild(enemy2)
        enemy2.Move(CCTime(3))
        
        
    }
    // Score
    func ccPhysicsCollisionBegin(pair: CCPhysicsCollisionPair!, Ufoship nodeA: CCNode!, floor nodeB: CCNode!) -> ObjCBool {
        score++
        nodeA.removeFromParent()
        return true
    }
    // Collision ship and ufo
    func ccPhysicsCollisionBegin(pair: CCPhysicsCollisionPair!, ship nodeA: CCNode!, Ufoship nodeB: CCNode!) -> ObjCBool {
        if (gameOver  == false) {
            triggerGameOver()
        }
        return true
    }
    
    // Gameover
    func triggerGameOver() {
        print("gameover")
        if (gameOver  == false) {
            
            userInteractionEnabled = false
            unschedule("spawnUfo")
            unschedule("spawnUfo2")
            gameEndScreen.visible = true
            scoreLabel.visible = false
            hero.opacity = 0 
            
            // GamoverTimeline
            if animationManager.runningSequenceName != "Gameover Timeline" {
                animationManager.runAnimationsForSequenceNamed("Gameover Timeline")
            }
            // Just in Case
            hero.stopAllActions()
            // Gameover Screen Movement Effect
            let move = CCActionEaseBounceOut(action: CCActionMoveBy(duration: 0.2, position: ccp(5, 5)))
            let moveBack = CCActionEaseBounceOut(action: move.reverse())
            let shakeSequence = CCActionSequence(array: [move, moveBack])
            runAction(shakeSequence)
            
        }
    }
}
