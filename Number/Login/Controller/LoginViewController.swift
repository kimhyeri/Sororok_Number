//
//  LoginViewController.swift
//  Number
//
//  Created by hyerikim on 2018. 7. 22..
//  Copyright © 2018년 nexters.number. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class LoginViewController: UIViewController {
    
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var numberText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    
    
    var param : [String:Any] = [:]
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        getDelegate()
        defaultPage()
        print(param)
    }
}

extension LoginViewController {
    
    //네비게이션 설정 해야함 사용자 정보 받기 성공했을 경우
    
    func setNavigationBar() {
        
        let screenSize: CGRect = UIScreen.main.bounds
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 20, width: screenSize.width, height: 44))
        let navItem = UINavigationItem(title: "")
        navBar.setBackgroundImage(UIImage(), for: .default)
        navBar.shadowImage = UIImage()
        let backButton = UIBarButtonItem(image: UIImage(named: "btnCommBackWh"), style: .plain, target: self, action: #selector(back))
        navItem.leftBarButtonItem = backButton
        backButton.imageInsets.left = -10
        
        let doneItem = UIBarButtonItem.init(title: "확인", style: .plain, target: nil, action: #selector(done))
        navItem.rightBarButtonItem = doneItem
        navBar.setItems([navItem], animated: false)
        navBar.tintColor = UIColor.white
        
        self.view.addSubview(navBar)
    }
    
    @objc func done() {
        let parameters : Parameters = [
            "phone": numberText.text!,
            "name": nameText.text!,
            "email": emailText.text!,
            "loginType": param["type"],
            "loginUid": UserInfo.getUid(),
            "memberImage":"",
            "imageUrl" : "",
            ]
        
        APICollection.sharedAPI.registeredCheck(parameters: parameters, completion: { result -> (Void) in
            let storyboard = UIStoryboard.init(name: "CodeNum", bundle: nil)
            let nv = storyboard.instantiateViewController(withIdentifier: "ST")
            self.present(nv, animated: true, completion: nil)
            UIApplication.shared.keyWindow?.rootViewController = nv
        })
    }
    
    @objc func back(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func defaultPage() {
        let dic = param.map{ $1 }
        do {
            let a = param["profile"] as! String
            let url = URL(string: a)
            let data = try Data(contentsOf: url!)
            self.imgProfile.image = UIImage(data: data)
        }
        catch{
            print(error)
        }
        self.imgProfile.layer.cornerRadius = imgProfile.frame.width/2
        self.nameText.text = (param["nickname"]) as! String
    }
    
    func getDelegate(){
        nameText.delegate = self
        numberText.delegate = self
        emailText.delegate = self
    }
    
}

//MARK: TextField Delegate extension part
extension LoginViewController : UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
}
