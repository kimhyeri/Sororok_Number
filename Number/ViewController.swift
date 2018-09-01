
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
import SwiftyJSON

class ViewController: UIViewController{
    
    @IBOutlet weak var google: UIButton!
    @IBOutlet weak var naver: UIButton!
    @IBOutlet weak var kakao: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
        checkLogin(memberId: 27)
        changeView()
    }
    
    func getAppDelegate() -> AppDelegate!{
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    func changeView(){
        google.layer.cornerRadius = 10
        naver.layer.cornerRadius = 10
        kakao.layer.cornerRadius = 10
    }
    
    func goNextPage(param:Param){
        let st = UIStoryboard.init(name: "Login", bundle: nil)
        let nv = st.instantiateViewController(withIdentifier: "Login") as! LoginViewController
        nv.param = param
        self.present(nv, animated: false, completion: nil)
    }
    
    //로그인 했는지 체크하기
    func checkLogin(type: String){
        let body : Parameters = [
            "type" : type,
            "uid" : UserInfo.getUid() ,
        ]
        
        APICollection.sharedAPI.registeredCheck(parameters: body, completion: {
            (result) -> (Void) in
      
        })
    }
    
    
    //사용자 정보 들고오기
    func checkLogin(memberId: Int){
        let memberId : Parameters = [
            "memberId" : memberId
            ]

        APICollection.sharedAPI.checkMemberInfo(parameter: memberId, completion: {
            (result) -> (Void) in
        })
        
    }
    
    @IBAction func naverButtonPressed(_ sender: UIButton){
        let loginInstance = NaverThirdPartyLoginConnection.getSharedInstance()
        loginInstance?.delegate = self
        loginInstance?.requestThirdPartyLogin()
    }
    
    @IBAction func googleButtonPressed(_ sender: UIButton) {
        GIDSignIn.sharedInstance().delegate=self
        GIDSignIn.sharedInstance().uiDelegate=self
        GIDSignIn.sharedInstance().signIn()
    }
    
    @IBAction func kakaoButtonPressed(_ sender: Any) {
        let session :KOSession = KOSession.shared()
        
        checkLogin(type: typeCase.kakao.rawValue)
        
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

//MARK: Naver Login
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

//MARK: Google Login
extension ViewController : GIDSignInUIDelegate , GIDSignInDelegate{
    
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
