//
//  ViewController.swift
//  Number
//
//  Created by hyerikim on 2018. 7. 22..
//  Copyright © 2018년 nexters.number. All rights reserved.
//

import UIKit
import Alamofire
import GoogleSignIn
import NaverThirdPartyLogin

class ViewController: UIViewController {

    @IBOutlet weak var google: UIButton!
    @IBOutlet weak var naver: UIButton!
    @IBOutlet weak var kakao: UIButton!
    
    let loginInstance = NaverThirdPartyLoginConnection.getSharedInstance()

    override func viewDidLoad() {
        super.viewDidLoad()
        changeView()
    }

    func changeView(){
        google.layer.cornerRadius = 10
        naver.layer.cornerRadius = 10
        kakao.layer.cornerRadius = 10
    }
    
    @IBAction func naverButtonPressed(_ sender: UIButton){
        loginInstance?.delegate = self
        loginInstance?.requestThirdPartyLogin()
    }
}

extension ViewController: NaverThirdPartyLoginConnectionDelegate{
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
            guard let number = object["number"] as? Int else {return}
            guard let name = object["name"] as? String else {return}
            guard let email = object["email"] as? String else {return}
            print(result)
        }
    }
}

