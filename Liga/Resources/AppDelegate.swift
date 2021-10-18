//
//  AppDelegate.swift
//  Liga
//
//  Created by Maxim Savchenko on 16.10.2021.
//

import UIKit
import GoogleMaps

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let googleMaps: GoogleMap = GoogleMapImp()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        googleMaps.generateKey()
        
        return true
    }

}

