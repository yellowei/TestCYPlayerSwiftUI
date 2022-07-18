//
//  TestCYPlayerSwiftUIApp.swift
//  TestCYPlayerSwiftUI
//
//  Created by yellowei on 2022/7/18.
//

import SwiftUI

@main
struct TestCYPlayerSwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: UIResponder, UIApplicationDelegate {

    static var orientationLock = UIInterfaceOrientationMask.portrait.rawValue | UIInterfaceOrientationMask.landscapeLeft.rawValue | UIInterfaceOrientationMask.landscapeRight.rawValue | UIInterfaceOrientationMask.portraitUpsideDown.rawValue
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        return true
    }

    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask(rawValue: AppDelegate.orientationLock)
    }
}

