//
//  AppDelegate.swift
//  MoreNumbersInput
//
//  Created by Stephan Jancar on 30.09.19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import BigInt
import PrimeFactors
import MoreNumbers


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
      window = UIWindow(frame: UIScreen.main.bounds)
        let homeViewController = ViewController()
        homeViewController.view.backgroundColor = UIColor.red
        window!.rootViewController = homeViewController
        window!.makeKeyAndVisible()
        return true

    }

}

