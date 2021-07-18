//
//  AppDelegate.swift
//  Plumbus
//
//  Created by Alexander Zhigulich on 7/15/2021.
//  Copyright © 2021. All rights reserved.
//

import Combine
import RickMortySwiftApi
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
}
