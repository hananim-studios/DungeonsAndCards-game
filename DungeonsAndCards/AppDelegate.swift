//
//  AppDelegate.swift
//  DungeonsAndCards
//
//  Created by Matheus Martins on 11/18/16.
//  Copyright © 2016 hananim. All rights reserved.
//

import UIKit
import HealthKit
import WatchConnectivity
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.requestAccessToHealthKit()
        
        // MARK: - Watch Connectivity
        if WCSession.isSupported() {
            let defaultSession = WCSession.default()
            defaultSession.delegate = ConnectionManager.sharedConnectionManager
            defaultSession.activate()
        }
        
        // MARK: - Load JSON
        if !HeroesJSON.load()   { fatalError("(☠) - HeroesJSON.load() failed") }
        if !ItemsJSON.load()    { fatalError("(☠) - ItemsJSON.load() failed") }
        if !EnemiesJSON.load()  { fatalError("(☠) - EenemiesJSON.load() failed") }
        
        // MARK: - Setup UserDefaults
        if UserDefaults.standard.bool(forKey: "hasLaunchedOnce") {
            
            UserDefaults.standard.set(true, forKey: "hasLaunchedOnce")
            UserDefaults.standard.set(false, forKey: "hasSavedGame")
            
            UserDefaults.standard.synchronize()
        }
        
        return true
    }

    private func requestAccessToHealthKit() {
        let healthStore = HKHealthStore()
        
        healthStore.requestAuthorization(toShare: [], read: [HKObjectType.activitySummaryType()]) { (success, error) in
            if !success {
                print(error!)
            }
        }
    }
    func applicationShouldRequestHealthAuthorization(_ application: UIApplication) {
        let healthStore = HKHealthStore()
        healthStore.handleAuthorizationForExtension { (success, error) in
            if success {
                print("Delegate- Auth granted")
            }
            else {
                print("Delegate- Error: \(error?.localizedDescription)")
            }
        }
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

}

