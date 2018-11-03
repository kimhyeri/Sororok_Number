//
//  CheckLogin.swift
//  Number
//
//  Created by hyerikim on 02/11/2018.
//  Copyright © 2018 nexters.number. All rights reserved.
//

import UIKit
import GoogleSignIn
import NaverThirdPartyLogin
import KakaoOpenSDK

//MARK: Check Login
extension AppDelegate : GIDSignInUIDelegate{
  
    @available(iOS 9.0, *)
    
    func checkLogin() {
        if UserDefaults.standard.bool(forKey: "isLoggedIn") == true {
            let st = UIStoryboard.init(name: "CodeNum", bundle: nil)
            let vc = st.instantiateViewController(withIdentifier: "ST") as! CustomNaviViewController
            window?.rootViewController = vc
        } else {
            let instance = NaverThirdPartyLoginConnection.getSharedInstance()
            instance?.isInAppOauthEnable = true
            instance?.isNaverAppOauthEnable = true
            instance?.isOnlyPortraitSupportedInIphone()
            instance?.serviceUrlScheme = kServiceAppUrlScheme
            instance?.consumerKey = kConsumerKey
            instance?.consumerSecret = kConsumerSecret
            instance?.appName = kServiceAppName
            
            GIDSignIn.sharedInstance().clientID = "485287400995-no0nk4j0g2lpk3v5n0h6pu8evqun5tvh.apps.googleusercontent.com"
        }
    }
    
    func application(_ application: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any]) -> Bool {

      if KOSession.isKakaoAccountLoginCallback(url) {
            return KOSession.handleOpen(url)
        } else {
            return GIDSignIn.sharedInstance().handle(url as URL?,sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String, annotation: options[UIApplicationOpenURLOptionsKey.annotation])
        }
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        
        if KOSession.isKakaoAccountLoginCallback(url) {
            return KOSession.handleOpen(url)
        }
        
        let googleSession = GIDSignIn.sharedInstance().handle(url,sourceApplication: sourceApplication, annotation: annotation)
        return googleSession
    }
    
}
