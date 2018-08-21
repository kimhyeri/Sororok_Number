//
//  LoginViewController.swift
//  Number
//
//  Created by hyerikim on 2018. 7. 22..
//  Copyright © 2018년 nexters.number. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var numberText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        getDelegate()
        defaultPage()
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
        let backbutton = UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: #selector(back))
        navItem.leftBarButtonItem = backbutton
        let doneItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: nil, action: #selector(done))
        navItem.rightBarButtonItem = doneItem
        navBar.setItems([navItem], animated: false)
        self.view.addSubview(navBar)
    }
    
    @objc func done() {
        let storyboard = UIStoryboard.init(name: "CodeNum", bundle: nil)
        let nv = storyboard.instantiateViewController(withIdentifier: "ST")
        present(nv, animated: true, completion: nil)
        UIApplication.shared.keyWindow?.rootViewController = nv
    }
    
    @objc func back(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func defaultPage() {
        
        self.imgProfile.layer.cornerRadius = imgProfile.frame.width/2
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
