//
//  AppDelegate.swift
//  DesafioFractal
//
//  Created by Joan Wilson Oliveira on 25/01/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.registerCustomFonts()
//        self.setupNavigationBar()
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

extension AppDelegate {
//    private func setupNavigationBar() {
//        let navigationBarAppearance = UINavigationBarAppearance()
//        self.setupNavigationBarFont(navigationBarAppearance)
//        self.setupBackButton(navigationBarAppearance)
//        navigationBarAppearance.backgroundColor = DesignSystem.Tokens.Colors.primary
//                
//    }
//    
    private func registerCustomFonts() {
        let fonts = Bundle.main.urls(forResourcesWithExtension: "ttf", subdirectory: nil)
        fonts?.forEach({ url in
            CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
        })
    }
//    
//    private func setupNavigationBarFont(_ navigationBarAppearance: UINavigationBarAppearance) {
//        let montserratFont: UIFont = DesignSystem.Tokens.Fonts.montserratSemiBold(20)
//        
//        navigationBarAppearance.titleTextAttributes = [
//            NSAttributedString.Key.foregroundColor: DesignSystem.Tokens.Colors.white,
//            NSAttributedString.Key.font: montserratFont
//        ]
//    }
//    
//    private func setupBackButton(_ navigationBarAppearance: UINavigationBarAppearance) {
////        navigationBarAppearance.topItem?.backButtonTitle = ""
////        navigationBarAppearance.backItem?.title = ""
////        navigationBarAppearance.tintColor = .white
//        navigationBarAppearance.backgroundColor = DesignSystem.Tokens.Colors.primary
//    }

}
