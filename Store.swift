////
////  Store.swift
////  MISSIONMARS2
////
////  Created by Frank Joseph Boccia on 3/8/16.
////  Copyright © 2016 Apportable. All rights reserved.
////
//
//import Foundation
//
//class Store: CCScene {
//    weak var homeButton: CCButton!
//    weak var ship2Button: CCButton!
//    weak var ship3Button: CCButton!
//    var alertShip2 = UIAlertView()
//    
//    func home(){
//        let scene = CCBReader.loadAsScene("StartScreen")
//        CCDirector.sharedDirector().presentScene(scene)
//
//    }
//    
//    func ship1() {
//        NSUserDefaults.standardUserDefaults().setInteger(1, forKey: "player")
//        let scene = CCBReader.loadAsScene("MainScene")
//        CCDirector.sharedDirector().presentScene(scene)
//    }
//    
//    func ship2() {
//        var OWEND = NSUserDefaults.standardUserDefaults().integerForKey("OWEND")
//        if OWEND < 1 {
//            alertShip2.tag = 2
//            alertShip2.delegate = self
//            alertShip2.title = "Buy this ship!"
//            alertShip2.message = "Buy this ship with 250 pristine gold coins. You know you want it!"
//            alertShip2.addButtonWithTitle("Purchase")
//            alertShip2.addButtonWithTitle("Cancel")
//            alertShip2.show()
//        }else {
//            NSUserDefaults.standardUserDefaults().setInteger(2, forKey: "player")
//            let scene = CCBReader.loadAsScene("MainScene")
//            CCDirector.sharedDirector().presentScene(scene)
//        }
//    }
//}
