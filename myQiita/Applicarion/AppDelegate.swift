//
//  AppDelegate.swift
//  myQiita
//
//  Created by aimon on 2019/08/11.
//  Copyright © 2019 a.naga. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        checkLogin()

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {

    }

    func applicationWillEnterForeground(_ application: UIApplication) {

    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }

}

extension AppDelegate {

    func checkLogin() {
        if !ApiTokenDataStore.haveApiToken() {
            let storyboard = UIStoryboard(name: "LoginView", bundle: nil)
            let loginViewController = storyboard.instantiateInitialViewController() as! LoginViewController
            self.window?.rootViewController = UINavigationController(rootViewController: loginViewController)
        }
    }
}


