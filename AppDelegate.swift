//
//  AppDelegate.swift
//  Parstagram2
//
//  Created by Sabahet Alovic on 10/19/20.
//  Copyright © 2020 Sabahet Alovic. All rights reserved.
//

import UIKit
import Parse
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,UIImagePickerControllerDelegate {

//Change

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
                 let parseConfig = ParseClientConfiguration {
                      $0.applicationId = "RHV4UpHJ6yCcDMS768EaIYmLwtQZVCUQHAbw94do"
                      $0.clientKey = "g6QlBCSkHq7N4dv0X2gxnECgtHB5pwYfVmpWNlvl"
                      $0.server = "https://parseapi.back4app.com"
              }
              Parse.initialize(with: parseConfig)
//        guard let windowScene = (scene as? UIWindowScene ) else {return}
//        if PFUser.current() != nil{
//             let main = UIStoryboard(name: "Main", bundle: nil)
//            self.window = UIWindow(windowScene: windowScene)
//            self.window?.rootViewController =
//            let feedNavigationController = main.instantiateViewController(withIdentifier: "FeedNavigationController")
       
            
        //}
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

