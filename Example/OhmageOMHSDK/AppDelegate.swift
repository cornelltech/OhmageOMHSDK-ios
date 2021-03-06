//
//  AppDelegate.swift
//  OhmageOMHSDK
//
//  Created by jdkizer9 on 01/12/2017.
//  Copyright (c) 2017 jdkizer9. All rights reserved.
//

import UIKit
import OhmageOMHSDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    static let StudyIdentifier = "RSuiteGeofenceStudy"
    
    var window: UIWindow?
    var ohmageManager: OhmageOMHManager!
    var locationManager: LocationManager!

    func createOhmageManager(logManager: LogManager?) -> OhmageOMHManager? {
        
        let omhClientDetails = NSDictionary(contentsOfFile: Bundle.main.path(forResource: "OMHClient", ofType: "plist")!)
        
        guard let baseURL = omhClientDetails?["OMHBaseURL"] as? String,
            let clientID = omhClientDetails?["OMHClientID"] as? String,
            let clientSecret = omhClientDetails?["OMHClientSecret"] as? String,
            let ohmageManager = OhmageOMHManager(
                baseURL: baseURL,
                clientID: clientID,
                clientSecret: clientSecret,
                queueStorageDirectory: "ohmageSDK",
                store: OhmageStore(),
                logger: logManager
            ) else {
                fatalError("Could not initialze OhmageManager")
        }
        
        return ohmageManager
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        debugPrint("\(application): didFinishLaunchingWithOptions")
        
        // Override point for customization after application launch.
        self.ohmageManager = createOhmageManager(logManager: LogManager.sharedInstance)
        self.locationManager = LocationManager(ohmageManager: self.ohmageManager)
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
        debugPrint("\(application): will resign active")
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        debugPrint("\(application): did enter background")
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
        debugPrint("\(application): applicationWillEnterForeground")
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        debugPrint("\(application): applicationDidBecomeActive")
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        
        debugPrint("\(app): openURL")
        
        return self.ohmageManager.handleURL(url: url)
    }
    
    static var appDelegate: AppDelegate! {
        return UIApplication.shared.delegate! as! AppDelegate
    }


}

