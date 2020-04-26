//
//  AppDelegate.swift
//  YoutubeFeeds
//
//  Created by Dong on 4/22/20.
//  Copyright © 2020 3bgroup. All rights reserved.
//

import UIKit



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        
        
        let layout = UICollectionViewFlowLayout() 
        window?.rootViewController = UINavigationController(rootViewController: HomeController(collectionViewLayout: layout) )
        
        //navigationController?.navigationBar.barTintColor = UIColor(displayP3Red: 230/255, green: 32/255, blue: 31/255, alpha: 1)
        //navigationController?.navigationBar.barTintColor = UIColor(displayP3Red: 230/255, green: 32/255, blue: 31/255, alpha: 1)
        
        //UINavigationBar.appearance().tintColor=UIColor(displayP3Red: 230/255, green: 32/255, blue: 31/255, alpha: 1)
        
        //UINavigationBar.appearance().tintColor = UIColor(displayP3Red: 230/255, green: 32/255, blue: 31/255, alpha: 1)
        
        let navigationBarAppearace = UINavigationBar.appearance()
        
        navigationBarAppearace.tintColor = .white
        navigationBarAppearace.barTintColor = UIColor(displayP3Red: 230/255, green: 32/255, blue: 31/255, alpha: 1)
        
        let statusBarBackgroundView = UIView()
        statusBarBackgroundView.backgroundColor = UIColor.rgb(displayP3Red: 194, green: 32, blue: 31, alpha: 1)
       
        
        let bottomBackgroundView = UIView()
        bottomBackgroundView.backgroundColor = UIColor.rgb(displayP3Red: 194, green: 32, blue: 31, alpha: 1)
        
        
        window?.addSubview(statusBarBackgroundView)
        window?.addConstraintsWithFormat(format: "H:|[v0]|", views: statusBarBackgroundView)
        
        window?.addSubview(bottomBackgroundView)
        window?.addConstraintsWithFormat(format: "H:|[v0]|", views: bottomBackgroundView)
        
        
        var topPadding:CGFloat = 0
        var bottomPadding:CGFloat = 0
        
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.keyWindow
            topPadding = window?.safeAreaInsets.top ?? 0
            bottomPadding = window?.safeAreaInsets.bottom ?? 0
        }
        
        window?.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0(vh)]", options: NSLayoutConstraint.FormatOptions(), metrics: ["vh":topPadding], views: ["v0":statusBarBackgroundView]))
        
        window?.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0(vh)]|", options: NSLayoutConstraint.FormatOptions(), metrics: ["vh":bottomPadding], views: ["v0":bottomBackgroundView]))
        
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

