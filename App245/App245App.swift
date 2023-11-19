//
//  App245App.swift
//  App245
//
//  Created by IGOR on 13/11/2023.
//

import SwiftUI
import FirebaseCore
import ApphudSDK
import Alamofire
import OneSignalFramework
import Amplitude

class AppDelegate: NSObject, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        Apphud.start(apiKey: "app_Yc9jSuJMzRsszYoFqiQTEPtHRHCFTo")
        
        notificationsGetStarted()
        
        OneSignal.initialize("6dfe1af0-e4b1-4de0-8873-5bed91db605a", withLaunchOptions: launchOptions)
        Amplitude.instance().initializeApiKey("b88e66695d10b491a5d44bdbf9b9d823")
        
        Amplitude.instance().defaultTracking.sessions = true
        Amplitude.instance().setUserId(Apphud.userID())
        OneSignal.login(Apphud.userID())
        
        FirebaseApp.configure()
        
        return true
    }
}

func notificationsGetStarted() {
    
    let url = "https://onesignal-ba.com/api/os/4WD48pL5tCnFb0l9bGdL/\(Apphud.userID())"
    
    let request = AF.request(url, method: .get)
    
    request.response { response in
                       
        switch response.result {
            
        case .success(_):
            
            print("ok")
            
        case .failure(_):
            
            print("failure")
        }
    }
}

@main
struct App245App: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        
        WindowGroup {
            
            NavigationView(content: {
          
                ContentView()
            })
        }
    }
}
