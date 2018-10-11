//
//  NaverLogin.swift
//  Number
//
//  Created by hyerikim on 12/10/2018.
//  Copyright © 2018 nexters.number. All rights reserved.
//

import UIKit
import NaverThirdPartyLogin
import Alamofire

//MARK: Naver Login
extension ViewController: NaverThirdPartyLoginConnectionDelegate{
    
    func naverLogin() {
        let loginInstance = NaverThirdPartyLoginConnection.getSharedInstance()
        loginInstance?.delegate = self
        loginInstance?.requestThirdPartyLogin()
    }
    
    func oauth20ConnectionDidOpenInAppBrowser(forOAuth request: URLRequest!) {
        let naverSignInViewController = NLoginThirdPartyOAuth20InAppBrowserViewController(request: request)!
        present(naverSignInViewController, animated: true, completion: nil)
    }
    
    func oauth20ConnectionDidFinishRequestACTokenWithAuthCode() {
        print("Success oauth20ConnectionDidFinishRequestACTokenWithAuthCode")
        getNaverEmailFromURL()
        
    }
    
    func oauth20ConnectionDidFinishRequestACTokenWithRefreshToken() {
        print("Success oauth20ConnectionDidFinishRequestACTokenWithRefreshToken")
        getNaverEmailFromURL()
        
    }
    
    func oauth20ConnectionDidFinishDeleteToken() {
        
    }
    
    func oauth20Connection(_ oauthConnection: NaverThirdPartyLoginConnection!, didFailWithError error: Error!) {
        print(error.localizedDescription)
        print(error)
    }
    
    func getNaverEmailFromURL(){
        guard let loginConn = NaverThirdPartyLoginConnection.getSharedInstance() else {return}
        guard let tokenType = loginConn.tokenType else {return}
        guard let accessToken = loginConn.accessToken else {return}
        
        let authorization = "\(tokenType) \(accessToken)"
        Alamofire.request("https://openapi.naver.com/v1/nid/me", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["Authorization" : authorization]).responseJSON { (response) in
            guard let result = response.result.value as? [String: Any] else {return}
            guard let object = result["response"] as? [String: Any] else {return}
            var sendParam = Param()
            if let name = object["name"] as? String {
                sendParam.name = name
            }
            if let email = object["email"] as? String {
                sendParam.email = email
            }
            if let profile = object["profile_image"] as? String {
                sendParam.imageUrl = profile
            }
            sendParam.loginType = typeCase.naver.rawValue
            sendParam.loginUid = UserInfo.getUid()
            
            self.goNextPage(param: sendParam)
        }
    }
}

