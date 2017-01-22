//
//  AppDelegate.swift
//  Walkr
//
//  Created by Josh Doman on 1/20/17.
//  Copyright © 2017 Josh Doman. All rights reserved.
//

import UIKit
import Firebase
import CoreLocation
import GoogleMaps
import GooglePlaces

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        FIRApp.configure()
        
        GMSServices.provideAPIKey("AIzaSyAs4UfwNjhm0i6Z_S_3KdOU_re6z0QNj-Y")
        GMSPlacesClient.provideAPIKey("AIzaSyABPmYDkcSH6ckja3hC01tasTBcVEsrSs0")
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        let user = User(uid: "c5aUMo0ca6ghrl2yiUyLTA5UFSm1", name: "Josh", imageUrl: "slkdjf", phone: "4046928439")
        User.current = user
        
        FIRAuth.auth()?.signIn(withEmail: "test@test.com", password: "12345678", completion: nil)

//        let startLocation = CLLocationCoordinate2D(latitude: 39.951507 , longitude: -75.193555)
//        let endLocation = CLLocationCoordinate2D(latitude: 39.953480 , longitude: -75.191414)
//        
        window?.rootViewController = MainContainerViewController()
        
        //FIRAuth.auth()?.createUser(withEmail: "test@test.com", password: "12345678", completion: nil)
        
        return true
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

