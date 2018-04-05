//
//  AppDelegate.swift
//  Todoey
//
//  Created by Daniil Grodskiy on 2/4/18.
//  Copyright © 2018 Daniil Grodskiy. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        //first thing that happens; runs before any of the other app even launches
        
        //print(Realm.Configuration.defaultConfiguration.fileURL)

        
        do {
            _ = try Realm()
        } catch {
            print("Error initializing new realm, \(error)")
        }
        
        
        
        

        return true
    }

}

