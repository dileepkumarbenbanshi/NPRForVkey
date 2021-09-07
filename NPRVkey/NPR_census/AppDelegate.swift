//
//  AppDelegate.swift
//  NPR_census
//
//  Created by admin on 04/08/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import CoreData
import Firebase
import IQKeyboardManagerSwift
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, VGuardManagerProtocol, VGuardThreatsDelegate, VGuardExceptionHandlerProtocol {
    
    func statusVOS(_ status: VOS_STATUS, withError error: Error!) {
        if status == VOS_OK
        {
            print("VOS OK")
        } else
        {
            print("error in starting VOS")
            print(error.localizedDescription)
        }
    }
    
    func statusVGuard(_ status: VGUARD_STATUS, withError error: Error!) {
        print(" V-key status \(status) \(String(describing: error))")
    }
    
    func vGuardDidFinishInitializing(_ status: Bool, withError error: Error!) {
        
    }
    
    func sslErroDetected(_ error: Error!) {
        
    }
    
    func vGuardExceptionHandler(_ exception: NSException!) {
        
    }
    

    var window: UIWindow?
    var vGuardMgr: VGuardManager!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()

    print("Documents Directory: ", FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last ?? "Not Found!")
        // Override point for customization after application launch.
        IQKeyboardManager.shared.enable = true
       // UINavigationBar.appearance().barStyle = .
        

        
       // vKeySetup()
        
        return true
        
       
    }
    
    func vKeySetup()  {
        
        vGuardMgr = VGuardManager.shared()
        vGuardMgr.delegate = self
        vGuardMgr.isDebug = false
        
       // vGuardMgr.getDFPHashHash()
        vGuardMgr.initializeVGuard()
        
        let exceptionHandler = VGuardExceptionHandler.sharedManager()
        exceptionHandler?.delegate = self
        
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
        if (vGuardMgr != nil) {
            vGuardMgr.start()
        }
       }

       func applicationWillTerminate(_ application: UIApplication) {
           // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
       }


    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "NPR_census")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

