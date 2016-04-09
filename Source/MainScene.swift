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
import AudioToolbox


class MainScene: CCNode, CCPhysicsCollisionDelegate {
    
    // Game Phyiscs Node
    weak var gamePhysicsNode: CCPhysicsNode!
    weak var gameEndScreen: GameEnd!
    weak var colorNode: CCNode!
    weak var redBackground: CCNode!
    weak var blueBackground: CCNode!
    weak var seaFoamBackground: CCNode!
    weak var steelBackground: CCNode!
    // Ships
    weak var hero: Ship!
    weak var enemy: Ufo!
    weak var enemy2: Ufo!
    weak var enemy3: Ufo!
    weak var enemy4: Ufo!
    weak var warningAlert: CCSprite!
    weak var warningAlert1: CCSprite!
    // Label
    weak var scoreLabel: CCLabelTTF!
    weak var holdToMove: CCLabelTTF!
    weak var warningLabel: CCLabelTTF!
    // Particles for Explosion 
    weak var explosion: CCParticleSystem!
    // touch/screen
    var currentTouchLocation: CGPoint!
    let screenSize = UIScreen.mainScreen().bounds
    var screenWidth = UIScreen.mainScreen().bounds.width
    var screenHeight = UIScreen.mainScreen().bounds.height
    // Gameover
    var gameOver: Bool = false
    // Sound
    let audio = OALSimpleAudio.sharedInstance()
    // Defaults
    let defaults = NSUserDefaults.standardUserDefaults()
    // Advertisements
    var startAppBanner: STABannerView?
    let view = CCDirector.sharedDirector().parentViewController!.view
    
    
    var score: Int = 0 {
        didSet {
            scoreLabel.string = "\(score)"
            
            if score == 3 {
                if gameOver == false {
                schedule("spawnUfo2", interval: 0.9)
                }
            }
            if score == 15 {
                hero.zOrder = +1
                blueBackground.visible = true
                schedule("spawnUfo3", interval: 1.5)
            }
            if score == 50 {
                hero.zOrder = +1
                redBackground.visible = true
                schedule("spawnUfo4", interval: 0.5)
                unschedule("spawnUfo")
                unschedule("spawnUfo2")
                unschedule("spawnUfo3")
            }
            if score == 75 {
                hero.zOrder = +1
                seaFoamBackground.visible = true
                schedule("spawnUfo3", interval: 0.7)
            }
            if score == 90 {
                schedule("spawnUfo2", interval: 0.5)
                unschedule("spawnUfo4")
            }
            if score == 150 {
                hero.zOrder = +1
                steelBackground.visible = true
                schedule("spawnUfo", interval: 0.3)
                    }
            if score == 200 {
                hero.zOrder = +1
                blueBackground.visible = true
                schedule("spawnUfo4", interval: 0.4)
                unschedule("spawnUfo3")
                unschedule("spawnUfo2")
                unschedule("spawnUfo")
                
            }
            if score == 275 {
                hero.zOrder = +1
                redBackground.visible = true
                schedule("spawnUfo", interval: 0.9)
            }
            if score == 300 {
                hero.zOrder = +1
                seaFoamBackground.visible = true
                unschedule("spawnUfo4")
                schedule("spawnUfo2", interval: 1.1)
                schedule("spawnUfo3", interval: 1.2)
            }
            if score == 350 {
                hero.zOrder = +1
                steelBackground.visible = true
            }
            if score == 400 {
                schedule("spawnUfo4", interval: 0.3)
                unschedule("spawnUfo")
                unschedule("spawnUfo2")
                unschedule("spawnUfo3")
                hero.zOrder = +1
                blueBackground.visible = true
                }
            }
    }
    
    func didLoadFromCCB(){
        
        userInteractionEnabled = true
        gamePhysicsNode.collisionDelegate = self
        
        if gameOver == false {
            gameEndScreen.visible = false
        }
    }
    // Advertisements
    func viewDidAppear(animated: Bool) {
        if (startAppBanner == nil) {
            startAppBanner = STABannerView(size: STA_AutoAdSize, autoOrigin: STAAdOrigin_Bottom, withView: self.view, withDelegate: nil);
            self.view.addSubview(startAppBanner!)
        }
    }
   
    func startGame(){
        schedule("spawnUfo", interval: 0.5)
        warningAlert.visible = false
        warningAlert1.visible = false
        warningLabel.visible = false
    }
    
    // touches
    override func touchBegan(touch: CCTouch!, withEvent event: CCTouchEvent!) {
        if gameOver == false {
            startGame()
            currentTouchLocation = touch.locationInWorld()
            holdToMove.visible = false
        }
        
    }
    override func touchMoved(touch: CCTouch!, withEvent event: CCTouchEvent!) {
        hero.position.x = CGFloat(clampf(Float(hero.position.x - (currentTouchLocation.x - touch.locationInWorld().x)),Float(0.0), Float(screenWidth)))
        currentTouchLocation = touch.locationInWorld()
    }
    // spawn Blue Ufo
    func spawnUfo() {
        let enemy = CCBReader.load("ufo") as! Ufo
        enemy.zOrder += 1
        //let x: CGFloat = CGFloat(arc4random_uniform(UInt32(CCDirector.sharedDirector().viewSize().width)))
        //let y: CGFloat = CCDirector.sharedDirector().viewSize().height
        enemy.position.x = hero.position.x
        enemy.position.y = 700
        //enemy.position = CGPoint(x: hero.position.x + screenWidth + enemy.contentSizeInPoints.width, y: hero.positionInPoints.y)
        gamePhysicsNode.addChild(enemy)
        enemy.Move(CCTime(3))
    }
    // spawn Red Ufo
    func spawnUfo2() {
        let enemy2 = CCBReader.load("ufo2") as! Ufo
        enemy2.zOrder += 1
        //let x: CGFloat = CGFloat(arc4random_uniform(UInt32(CCDirector.sharedDirector().viewSize().width)))
        //let y: CGFloat = CCDirector.sharedDirector().viewSize().height
        enemy2.position.x = hero.position.x
        enemy2.position.y = 700
        gamePhysicsNode.addChild(enemy2)
        enemy2.Move(CCTime(3))
    }
    
    // spawn Red Ufo
    func spawnUfo3() {
        let enemy3 = CCBReader.load("ufo3") as! Ufo
        enemy3.zOrder += 1
        //let x: CGFloat = CGFloat(arc4random_uniform(UInt32(CCDirector.sharedDirector().viewSize().width)))
        //let y: CGFloat = CCDirector.sharedDirector().viewSize().height
        enemy3.position.x = hero.position.x
        enemy3.position.y = 700
        gamePhysicsNode.addChild(enemy3)
        enemy3.Move(CCTime(3))
    }
    // spawn Penguin Ufo
    func spawnUfo4() {
        let enemy4 = CCBReader.load("ufo4") as! Ufo
        enemy4.zOrder += 1
        //let x: CGFloat = CGFloat(arc4random_uniform(UInt32(CCDirector.sharedDirector().viewSize().width)))
        //let y: CGFloat = CCDirector.sharedDirector().viewSize().height
        enemy4.position.x = hero.position.x
        enemy4.position.y = 700
        gamePhysicsNode.addChild(enemy4)
        enemy4.Move(CCTime(3))
    }
    // Score
    func ccPhysicsCollisionBegin(pair: CCPhysicsCollisionPair!, Ufoship nodeA: CCNode!, floor nodeB: CCNode!) -> ObjCBool {
        if (gameOver == false) {
            score++
        }
        
        nodeA.removeFromParent()
        return true
    }
    // Collision ship and ufo
//    func ccPhysicsCollisionBegin(pair: CCPhysicsCollisionPair!, ship nodeA: CCNode!, Ufoship nodeB: CCNode!) -> ObjCBool {
//        if (gameOver  == false) {
//            triggerGameOver()
//        }
//        return true
//    }
    // Gameover
    func triggerGameOver() {
        print("gameover")
        if (gameOver  == false) {
            
            userInteractionEnabled = false
            unschedule("spawnUfo")
            unschedule("spawnUfo2")
            unschedule("spawnUfo3")
            unschedule("spawnUfo4")
            gameEndScreen.visible = true
            scoreLabel.visible = false
            hero.opacity = 0
            warningAlert.visible = false
            warningAlert1.visible = false
            warningLabel.visible = false
         
            // GamoverTimeline
            if animationManager.runningSequenceName != "Gameover Timeline" {
                warningAlert.visible = false
                warningAlert1.visible = false
                warningLabel.visible = false
                animationManager.runAnimationsForSequenceNamed("Gameover Timeline")
                gameEndScreen.saveHighScore(score)

            }
            
            // Explosion Particle Effect
            let explosion = CCBReader.load("Explosion")
            explosion.zOrder = +1
            explosion.position = hero.positionInPoints
            hero.explosion()
            addChild(explosion)
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
