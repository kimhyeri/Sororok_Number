//
//  LoginViewController.swift
//  Number
//
//  Created by hyerikim on 2018. 7. 22..
//  Copyright © 2018년 nexters.number. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var numTextField: UITextField!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var timeDown: UILabel!
    
    var time = 180
    var timer = Timer()
    var startTimer = false
    
    //numTextField변화 살펴보기
    @IBAction func numberEditing(_ sender: UITextField) {
        if (sender.text?.count)! == 0 {
            sender.backgroundColor = .white
            sender.textColor = .lightGray
    
        }else {
            sender.backgroundColor = .lightGray
            sender.textColor = .white
        }
    }
    
    //인증번호 전송
    @IBAction func pressedButton(_ sender: UIButton) {
        sender.setTitle("메일 재전송", for: UIControlState.normal)
        if startTimer == false {
            startTimer = true
            timeLimitStart()
        }
    }
    
    //로그인 버튼 눌렀을 때 -> 다음화면으로 전환 
    @IBAction func pressLoginButton(_ sender: Any) {
        timeLimitStop()
        let storyboard = UIStoryboard.init(name: "CodeNum", bundle: nil)
        let nv = storyboard.instantiateViewController(withIdentifier: "CodeNum") as! CodeNumViewController
        present(nv, animated: true, completion: nil)
        UIApplication.shared.keyWindow?.rootViewController = nv
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        numTextField.delegate = self
        
    }

}


//MARK: TextField Delegate extension part
extension LoginViewController : UITextFieldDelegate {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
}
