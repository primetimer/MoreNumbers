//
//  AppDelegate.swift
//  MoreNumbers
//
//  Created by primetimer on 02/23/2019.
//  Copyright (c) 2019 primetimer. All rights reserved.
//

import UIKit
//import BigInt
//import PrimeFactors
//import MoreNumbers

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
      window = UIWindow(frame: UIScreen.main.bounds)
        let homeViewController = ViewController()
        homeViewController.view.backgroundColor = UIColor.red
        window!.rootViewController = homeViewController
        window!.makeKeyAndVisible()
        return true

    }
}

