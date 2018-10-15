//
//  GoogleLogin.swift
//  Number
//
//  Created by hyerikim on 12/10/2018.
//  Copyright © 2018 nexters.number. All rights reserved.
//

import UIKit
import GoogleSignIn

//MARK: Google Login
extension ViewController : GIDSignInUIDelegate , GIDSignInDelegate{
    
    func googleLogin(){
        checkLogin(loginType: typeCase.google.rawValue)
        GIDSignIn.sharedInstance().delegate=self
        GIDSignIn.sharedInstance().uiDelegate=self
        GIDSignIn.sharedInstance().signIn()
    }
    
    func sign(_ signIn: GIDSignIn!,
              present viewController: UIViewController!) {
        self.present(viewController, animated: true, completion: nil)
    }
    
    func sign(_ signIn: GIDSignIn!,
              dismiss viewController: UIViewController!) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print("\(error.localizedDescription)")
        } else {
            var sendParam = Param()
            if let fullName = user.profile.name {
                sendParam.name = fullName
            }
            if let email = user.profile.email {
                sendParam.email = email
            }
            if let profile = user.profile.imageURL(withDimension: 400) {
                sendParam.imageUrl = try? String(contentsOf: profile)
            }
            sendParam.loginType = typeCase.google.rawValue
            sendParam.loginUid = UserInfo.getUid()
            
            self.goNextPage(param: sendParam)
        }
    }
}
