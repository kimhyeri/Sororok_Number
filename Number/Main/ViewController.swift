
//
//  ViewController.swift
//  Number
//
//  Created by hyerikim on 2018. 7. 22..
//  Copyright © 2018년 nexters.number. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController{
    
    @IBOutlet weak var google: UIButton!
    @IBOutlet weak var naver: UIButton!
    @IBOutlet weak var kakao: UIButton!
    
    var userData : UserInfoSet!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        defaultView()
    }
    
    @IBAction func naverButtonPressed(_ sender: UIButton){
       naverLogin()
    }
    
    @IBAction func googleButtonPressed(_ sender: UIButton) {
       googleLogin()
    }
    
    @IBAction func kakaoButtonPressed(_ sender: Any) {
        kakaoLogin()
    }
    
    func getAppDelegate() -> AppDelegate!{
        return (UIApplication.shared.delegate as! AppDelegate)
    }
    
    //로그인 체크하기
    func checkLogin(type: String){
        let body : Parameters = [
            "type" : type,
            "uid" : UserInfo.getUid() ,
            ]
        
        APICollection.sharedAPI.registeredCheck(parameters: body, completion: {
            (result) -> (Void) in
        })
    }
    
    func goNextPage(param:Param){
        let st = UIStoryboard.init(name: "Login", bundle: nil)
        let nv = st.instantiateViewController(withIdentifier: "Login") as! LoginViewController
        nv.param = param
        self.present(nv, animated: false, completion: nil)
    }
    
}
