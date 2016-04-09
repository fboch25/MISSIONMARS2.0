//
//  AppDelegate.swift
//  MISSIONMARS2
//
//  Created by Frank Joseph Boccia on 4/8/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

import Foundation

class AppDelegate: CCAppDelegate {
    
    override func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // initialize the SDK with your appID and devID
        var sdk: STAStartAppSDK = STAStartAppSDK.sharedInstance()
        sdk.appID = "203081234"
        sdk.devID = "108930826"
        
        return true
    }
}