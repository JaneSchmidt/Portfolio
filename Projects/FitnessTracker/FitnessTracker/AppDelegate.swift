//
//  AppDelegate.swift
//  FitnessTracker
//
//  Created by Jane Schmidt on 4/7/22.
//
/*
 Ashley Ziegler amziegle@iu.edu
 Jane Schmidt schmija@iu.edu
 Taylor Yang tayyang@iu.edu
 Fitness Tracker
 5/5/2022
 */

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var myModel: Model = Model()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //persistent data retrieval
        do {
            let fm = FileManager.default
            let docsurl = try fm.url(for:.documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)

            print("retrieving saved plist array of Items")
            let arrFile = docsurl.appendingPathComponent("itemArr.plist")
            let arrayData = try Data(contentsOf: arrFile)
            let itemArr = try PropertyListDecoder().decode([Item].self, from:arrayData)
            print(itemArr)
            let items = try String.init(contentsOf: arrFile)
            print(items) // show it as XML
            myModel.initializeArr(savedArr:itemArr)
            print(myModel.getLastDuration())
            print(myModel.getLastMiles())
        } catch {
            print(error)
        }
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}

