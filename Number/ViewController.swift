//
//  ViewController.swift
//  Number
//
//  Created by hyerikim on 2018. 7. 22..
//  Copyright © 2018년 nexters.number. All rights reserved.
//

import UIKit
import GoogleSignIn

class ViewController: UIViewController {

    @IBOutlet weak var google: UIButton!
    @IBOutlet weak var naver: UIButton!
    @IBOutlet weak var kakao: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        google.layer.cornerRadius = 10
        naver.layer.cornerRadius = 10
        kakao.layer.cornerRadius = 10
        
//
//        GIDSignIn.sharedInstance().uiDelegate = self
//
//        let googleSignInbutton = GIDSignInButton()
//        googleSignInbutton.center = view.center
//        view.addSubview(googleSignInbutton)
    }

}

