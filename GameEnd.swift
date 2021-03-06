//
//  GameEnd.swift
//  MISSIONMARS2
//
//  Created by Frank Joseph Boccia on 3/5/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

import Foundation
import AudioToolbox
import GameKit

class GameEnd: CCNode {
    
    weak var pointsLabel: CCLabelTTF!
    weak var highPointsLabel: CCLabelTTF!
    weak var homeButton: CCButton!
    weak var settingsButton: CCButton!
    weak var leaderBoardButton: CCButton!
    weak var storeButton: CCButton!
    let defaults = NSUserDefaults.standardUserDefaults()
    

    // Save Highscore in Game Center 
    func saveHighScore(score : Int) {
        var currentHighscore = defaults.integerForKey("highScore")
        if score > currentHighscore {
            defaults.setInteger(score, forKey: "highScore")
        }
        currentHighscore = defaults.integerForKey("highScore")

        if score < currentHighscore {
        pointsLabel.string = "\(score)"
        } else {
            pointsLabel.string = "\(currentHighscore)"
        }
        if GKLocalPlayer.localPlayer().authenticated {
            let scoreReporter = GKScore(leaderboardIdentifier: "MissionMars2SinglePlayerLeaderBoard")
            scoreReporter.value = Int64(score)
            let scoreArray: [GKScore] = [scoreReporter]
            GKScore.reportScores(scoreArray,withCompletionHandler: ( {
                (error : NSError?)-> Void in
                if (error != nil) {
                    print("Error: " + error!.localizedDescription, terminator: "");
                }
            } ) )
        }
        highPointsLabel.string = "\(currentHighscore)"
    }
    
    // restart Game
    func restart() {
        let scene = CCBReader.loadAsScene("MainScene")
        CCDirector.sharedDirector().presentScene(scene)
    }
    // store
    func store(){
        let scene = CCBReader.loadAsScene("Store")
        CCDirector.sharedDirector().presentScene(scene)
    }
    func home() {
        let scene = CCBReader.loadAsScene("StartScreen")
        CCDirector.sharedDirector().presentScene(scene)
    }
    func openLeaderBoard() {
        showLeaderBoard()
    }
}

// MARK: Game Center Handling
extension GameEnd: GKGameCenterControllerDelegate {
    
    func showLeaderBoard() {
        let viewController = CCDirector.sharedDirector().parentViewController!
        let gameCenterViewController = GKGameCenterViewController()
        gameCenterViewController.gameCenterDelegate = self
        viewController.presentViewController(gameCenterViewController, animated: true, completion: nil)
    }
    
    // Delegate methods
    func gameCenterViewControllerDidFinish(gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
