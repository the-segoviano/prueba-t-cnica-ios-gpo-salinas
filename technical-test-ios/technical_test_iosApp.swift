//
//  technical_test_iosApp.swift
//  technical-test-ios
//
//  Created by Luis Segoviano on 04/08/25.
//

import SwiftUI
import FirebaseCore
import FirebaseDatabase

@main
struct technical_test_iosApp: App {
    
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    
}


class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        Database.database().isPersistenceEnabled = true // Para cache local
        
        return true
    }
    
}

