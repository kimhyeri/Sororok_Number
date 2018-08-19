//
//  ViewController.swift
//  Number
//
//  Created by hyerikim on 2018. 7. 22..
//  Copyright © 2018년 nexters.number. All rights reserved.
//

import UIKit
import GoogleSignIn
import Google

class ViewController: UIViewController , GIDSignInDelegate, GIDSignInUIDelegate{
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if error != nil{
            print(error)
            return
        }
        //이메일 받기
        print(user.profile.email)
    }
    

    @IBOutlet weak var google: UIButton!
    @IBOutlet weak var naver: UIButton!
    @IBOutlet weak var kakao: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        google.layer.cornerRadius = 10
        naver.layer.cornerRadius = 10
        kakao.layer.cornerRadius = 10
        
        var error: NSError?
        
        GGLContext.sharedInstance().configureWithError(&error)
        
        if error != nil{
            print(error)
            return
        }
        
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
        
        let googleSignInbutton = GIDSignInButton()
        googleSignInbutton.center = view.center
        view.addSubview(googleSignInbutton)
    }


}

