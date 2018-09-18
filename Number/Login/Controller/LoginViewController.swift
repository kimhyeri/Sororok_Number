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
import Photos

class LoginViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var textView: UIView!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var numberText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    
    var defaultFrame : CGRect?
    var userData : UserInfoSet!
    var param : Param?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        getDelegate()
        defaultPage()
    }
    
    //사용자가 직접 프로필 사진 선택한 경우 
    @IBAction func albumButtonPressed(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = false
        self.present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        self.imgProfile.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        picker.dismiss(animated: false)
    }
}

extension LoginViewController {
    
    @objc func done(){
        //사진이 url 경로인 경우 , 사진 파일인 경우

        let url = URL(string: "http://45.63.120.140:40005/member/join")
        
        let phone = numberText.text!
        let name = nameText.text!
        let email = emailText.text!
        var imageUrl = ""
//        if param?.imageUrl != nil {
//            imageUrl = (param?.imageUrl)!
//        }
        let loginType = (param?.loginType)!
        let loginUid = (param?.loginUid)!

//        if param?.imageUrl == nil {
//            let memberImage = imgProfile.image

            Alamofire.upload(
                multipartFormData: { multipartFormData in
//                    multipartFormData.append(UIImageJPEGRepresentation(memberImage!, 0.1)!, withName: "memberImage", fileName: "file.jpeg", mimeType: "image/jpeg")
                    multipartFormData.append((phone.data(using: String.Encoding.utf8, allowLossyConversion: false))!, withName: "phone")
                    multipartFormData.append((name.data(using: String.Encoding.utf8, allowLossyConversion: false))!, withName: "name")
                    multipartFormData.append((email.data(using: String.Encoding.utf8, allowLossyConversion: false))!, withName: "email")
                    multipartFormData.append((loginType.data(using: String.Encoding.utf8, allowLossyConversion: false))!, withName: "loginType")
                    multipartFormData.append((loginUid.data(using: String.Encoding.utf8, allowLossyConversion: false))!, withName: "loginUid")
            },
                to: url!,
                method: .put,
                encodingCompletion: { encodingResult in
                    switch encodingResult {
                    case .success(let upload, _, _):
                        upload.responseJSON { response in
                            let json = JSON(response.result.value)
                            self.userData = UserInfoSet(rawJson: json)
                            UserDefaults.standard.set(self.userData.memberId, forKey: "memberId")
                            UserDefaults.standard.set(self.userData.email, forKey: "email")
                            UserDefaults.standard.set(self.userData.name, forKey: "name")
                            UserDefaults.standard.set(self.userData.phone, forKey: "phone")
//                            UserDefaults.standard.set(self.userData.imageName, forKey: "imageName")
                            self.moveToMain(memberId: self.userData.memberId!)
                        }
                    case .failure(let encodingError):
                        print(encodingError)
                    }
            })
        }

//        Alamofire.upload(
//            multipartFormData: { multipartFormData in
//                multipartFormData.append((phone.data(using: String.Encoding.utf8, allowLossyConversion: false))!, withName: "phone")
//                multipartFormData.append((name.data(using: String.Encoding.utf8, allowLossyConversion: false))!, withName: "name")
//                multipartFormData.append((email.data(using: String.Encoding.utf8, allowLossyConversion: false))!, withName: "email")
//                multipartFormData.append((loginType.data(using: String.Encoding.utf8, allowLossyConversion: false))!, withName: "loginType")
//                multipartFormData.append((loginUid.data(using: String.Encoding.utf8, allowLossyConversion: false))!, withName: "loginUid")
//                multipartFormData.append((imageUrl.data(using: String.Encoding.utf8, allowLossyConversion: false))!, withName: "imageUrl")
//        },
//            to: url!,
//            method: .put,
//            encodingCompletion: { encodingResult in
//                switch encodingResult {
//                case .success(let upload, _, _):
//                    upload.responseJSON { response in
//                        let json = JSON(response.result.value)
//                        self.userData = UserInfoSet(rawJson: json)
//                        UserDefaults.standard.set(self.userData.memberId, forKey: "memberId")
//                        UserDefaults.standard.set(self.userData.email, forKey: "email")
//                        UserDefaults.standard.set(self.userData.name, forKey: "name")
//                        UserDefaults.standard.set(self.userData.phone, forKey: "phone")
////                        UserDefaults.standard.set(self.userData.imageName, forKey: "imageName")
//                        self.moveToMain(memberId: self.userData.memberId!)
//                    }
//                case .failure(let encodingError):
//                    print(encodingError)
//                }
//        })
//    }

    @objc func back(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func defaultPage() {
        defaultFrame = textView.frame
        emailText.delegate = self
        numberText.delegate = self
        nameText.delegate = self
        
        self.imgProfile.layer.cornerRadius = imgProfile.frame.width/2
        if param?.email != nil { self.emailText.text = param?.email }
        if param?.name != nil { self.nameText.text = param?.name}
//        if param?.imageUrl != nil {
//            do {
//            let img = param?.imageUrl
//            let url = URL(string: img!)
//            let data = try Data(contentsOf: url!)
//            self.imgProfile.image = UIImage(data: data)
//            }
//            catch{ print(error) }
//        }
    }
    
    func getDelegate(){
        nameText.delegate = self
        numberText.delegate = self
        emailText.delegate = self
    }
    
    func moveToMain(memberId: Int){
        self.showToast(message: "회원가입 성공")
        
        let st = UIStoryboard.init(name: "CodeNum", bundle: nil)
        let vc = st.instantiateViewController(withIdentifier: "ST") as! CustomNaviViewController
        self.present(vc, animated: true, completion: nil)
        
        UserDefaults.standard.set(true, forKey: "isLoggedIn")
        UserDefaults.standard.synchronize()
        UserDefaults.standard.set(memberId, forKey: "memberId")
    }
}

//MARK: TextField Delegate extension part
extension LoginViewController : UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
        textView.frame = defaultFrame!
    }
    
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        viewUp()
//    }
    
    func viewUp() {
        textView.frame = CGRect(x: 0, y: 65, width: self.view.frame.width, height: textView.frame.height)
    }
}
