//
//  AppDelegate.swift
//  ChatApp
//
//  Created by MacMini on 18/07/2019.
//  Copyright © 2019 com.blablabla. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        checkAuthSignIn()
        return true
    }

    func checkAuthSignIn() {
        
        guard
            let firebaseUser = Auth.auth().currentUser,
            let user = User(firebaseUser: firebaseUser)
            else { return }
        
        let chatStoryboard = UIStoryboard(name: "Chat", bundle: .main)
        
        guard
            let navigationController = chatStoryboard.instantiateInitialViewController() as? UINavigationController,
            let messageVC = navigationController.topViewController as? MessagesVC
            else { return }
        messageVC.user = user
        
        window?.rootViewController = navigationController
        
    }


}

