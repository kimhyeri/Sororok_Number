//
//  KaKaoLogin.swift
//  Number
//
//  Created by hyerikim on 12/10/2018.
//  Copyright © 2018 nexters.number. All rights reserved.
//

import UIKit

//MARK: Kakao Login
extension ViewController {
    
    func kakaoLogin() {
        let session :KOSession = KOSession.shared()
        
        checkLogin(loginType: typeCase.kakao.rawValue)
        
        if session.isOpen() {
            session.close()
        }
        
        session.presentingViewController = self
        session.open(completionHandler: {(error) -> Void in
            
            if error != nil {
                print(error?.localizedDescription ?? "")
            }else if session.isOpen() {
                KOSessionTask.meTask(completionHandler: {(profile, error) -> Void in
                    
                    if profile != nil {
                        DispatchQueue.main.async(execute: { () -> Void in
                            let kakao : KOUser = profile as! KOUser
                            guard (self.getAppDelegate()) != nil else{
                                return
                            }
                            var sendParam = Param()
                            if let name = kakao.properties?["nickname"] as? String{
                                sendParam.name = name
                            }
                            if let profile = kakao.properties?["profile_image"] as? String {
                                sendParam.imageUrl = profile
                            }
                            if let email = kakao.properties?["email"] as? String {
                                sendParam.email = email
                            }
                            
                            sendParam.loginType = typeCase.kakao.rawValue
                            sendParam.loginUid = UserInfo.getUid()
                            
                            self.goNextPage(param: sendParam)
                            _ = self.getAppDelegate()
                        })
                    }
                })
            } else { print("not open") }
        })
    }
}

