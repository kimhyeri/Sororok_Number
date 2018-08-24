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

class ViewController: UIViewController, GIDSignInUIDelegate {
    
    @IBOutlet weak var google: UIButton!
    @IBOutlet weak var naver: UIButton!
    @IBOutlet weak var kakao: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().uiDelegate = self
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
    
    @IBAction func naverButtonPressed(_ sender: UIButton){
        let loginInstance = NaverThirdPartyLoginConnection.getSharedInstance()
        loginInstance?.delegate = self
        loginInstance?.requestThirdPartyLogin()
    }
    
    @IBAction func googleButtonPressed(_ sender: Any) {
        
//        let parameters : Parameters = [
//            "type": "0",
//            "uid": UserInfo.getUid(),
//        ]
//
//        APICollection.sharedAPI.registeredCheck(parameters: parameters, completion: { result -> (Void) in
//            let storybaord = UIStoryboard.init(name: "CodeNum", bundle: nil)
//            let vc = storybaord.instantiateViewController(withIdentifier: "ST")
//            self.present(vc, animated: true, completion: nil)
//
//        })
    }
    
    @IBAction func kakaoButtonPressed(_ sender: Any) {
        let session :KOSession = KOSession.shared()
        
        if session.isOpen() {
            session.close()
        }
        
        session.presentingViewController = self
        session.open(completionHandler: {(error) -> Void in
            print("hello")
            if error != nil {
                print(error?.localizedDescription ?? "")
            }else if session.isOpen() {
                print("카카오 로그인 성공")

                KOSessionTask.meTask(completionHandler: {(profile, error) -> Void in
                    
                    if profile != nil {
                        DispatchQueue.main.async(execute: { () -> Void in
                            let kakao : KOUser = profile as! KOUser
                            print(String(describing: kakao.id))
                            guard (self.getAppDelegate()) != nil else{
                                return
                            }
                            
                            if let value = kakao.properties?["nickname"] as? String{
                                print("nicknam = \(value)")
                            }
                            if let value = kakao.properties?["profile_image"] as? String {
                                print("profile image = \(value)")
                            }
                            if let value = kakao.email{
                                print("kakao email : \(value)")
                            }
                            let st = UIStoryboard.init(name: "Login", bundle: nil)
                            let nv = st.instantiateViewController(withIdentifier: "Login") as! LoginViewController
                            nv.param = ["nickname" : kakao.properties?["nickname"],
                                        "profile": kakao.properties?["profile_image"],
                                        "type": typeCase.kakao.hashValue]
                            self.present(nv, animated: false, completion: nil)
                            let appDelegate = self.getAppDelegate()

                        })
                    }
                })
            } else {
                print("not open")
            }
        })
    }
}

extension ViewController: NaverThirdPartyLoginConnectionDelegate{
    func oauth20ConnectionDidOpenInAppBrowser(forOAuth request: URLRequest!) {
        print("1")
        let naverSignInViewController = NLoginThirdPartyOAuth20InAppBrowserViewController(request: request)!
        present(naverSignInViewController, animated: true, completion: nil)
    }
    
    func oauth20ConnectionDidFinishRequestACTokenWithAuthCode() {
        print("2")
        
        print("Success oauth20ConnectionDidFinishRequestACTokenWithAuthCode")
        getNaverEmailFromURL()
        
    }
    
    func oauth20ConnectionDidFinishRequestACTokenWithRefreshToken() {
        print("3")
        
        print("Success oauth20ConnectionDidFinishRequestACTokenWithRefreshToken")
        getNaverEmailFromURL()
        
    }
    
    func oauth20ConnectionDidFinishDeleteToken() {
        print("4")
        
    }
    
    func oauth20Connection(_ oauthConnection: NaverThirdPartyLoginConnection!, didFailWithError error: Error!) {
        print("5")
        
        print(error.localizedDescription)
        print(error)
    }
    
    func getNaverEmailFromURL(){
        print("6")
        
        guard let loginConn = NaverThirdPartyLoginConnection.getSharedInstance() else {return}
        guard let tokenType = loginConn.tokenType else {return}
        guard let accessToken = loginConn.accessToken else {return}
        
        let authorization = "\(tokenType) \(accessToken)"
        Alamofire.request("https://openapi.naver.com/v1/nid/me", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["Authorization" : authorization]).responseJSON { (response) in
            guard let result = response.result.value as? [String: Any] else {return}
            //            guard let object = result["response"] as? [String: Any] else {return}
            //            guard let number = object["number"] as? Int else {return}
            //            guard let name = object["name"] as? String else {return}
            //            guard let email = object["email"] as? String else {return}
            print(result)
        }
        
    }
}

//google
extension ViewController {
 
    // Present a view that prompts the user to sign in with Google
    func signIn(signIn: GIDSignIn!,
                presentViewController viewController: UIViewController!) {
        self.present(viewController, animated: true, completion: nil)
    }
    
    // Dismiss the "Sign in with Google" view
    func signIn(signIn: GIDSignIn!,
                dismissViewController viewController: UIViewController!) {
        self.dismiss(animated: true, completion: nil)
    }
}
