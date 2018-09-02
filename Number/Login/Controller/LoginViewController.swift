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

class LoginViewController: UIViewController {
    
    @IBOutlet weak var textView: UIView!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var numberText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    
    var defaultFrame : CGRect?
    var param : Param?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        getDelegate()
        defaultPage()
    }
    
    @IBAction func albumButtonPressed(_ sender: Any) {
        let st = UIStoryboard.init(name: "MyPage", bundle: nil)
        let vc = st.instantiateViewController(withIdentifier: "Album") as! AlbumViewController
        vc.albumSelectionDelegate = self
        self.navigationController?.pushViewController(vc, animated: true)
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
    
    @objc func done(){
        
        let parameters = [
        "phone" : numberText.text!,
        "name" : nameText.text!,
        "email" : emailText.text!,
        "loginType" : (param?.loginType)!,
        "loginUid" : (param?.loginUid)!
//        "memberImage" : (param?.memberImage)!,
//        "imageUrl" : (param?.imageUrl)!]
        ] as Parameters

        print(parameters)
        let url = URL(string: "http://45.63.120.140:40005/member/join")
    
        let phone = numberText.text!
        let name = nameText.text!
        let email = emailText.text!
        let loginType = (param?.loginType)!
        let loginUid = (param?.loginUid)!
        
        Alamofire.upload(
            multipartFormData: { multipartFormData in
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
                        print(response.result.value)
                        print(response.result)
                        print(response.data)
                    }
                case .failure(let encodingError):
                    print(encodingError)
                }
        })
    }

    @objc func back(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func defaultPage() {
        defaultFrame = textView.frame
        emailText.delegate = self
        numberText.delegate = self
        nameText.delegate = self
        
        self.imgProfile.layer.cornerRadius = imgProfile.frame.width/2
        if param?.email != nil {
            self.emailText.text = param?.email
        }
        if param?.name != nil {
            self.nameText.text = param?.name
        }
        if param?.imageUrl != nil {
            do {
            let img = param?.imageUrl
            let url = URL(string: img!)
            let data = try Data(contentsOf: url!)
            self.imgProfile.image = UIImage(data: data)
            }
            catch{
                print(error)
            }
        }
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
        textView.frame = defaultFrame!
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        viewUp()
    }
    
    func viewUp() {
        textView.frame = CGRect(x: 0, y: 65, width: self.view.frame.width, height: textView.frame.height)
    }
}

extension LoginViewController : AlbumSelectionDelegate{
    func didSelectImage(asset: PHAsset) {
        var img: UIImage?
        let manager = PHImageManager.default()
        let options = PHImageRequestOptions()
        options.version = .original
        options.isSynchronous = true
        manager.requestImageData(for: asset, options: options) { data, _, _, _ in
            
            if let data = data {
                img = UIImage(data: data)
            }
        }
        imgProfile.image = img
    }
}

struct JSONStringArrayEncoding: ParameterEncoding {
    private let array: [String: Any]
    
    init(array: [String : Any]) {
        self.array = array
    }
    
    func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
            var urlRequest = try urlRequest.asURLRequest()
            let data = try JSONSerialization.data(withJSONObject: array, options: [])
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
            urlRequest.httpBody = data
            return urlRequest
    }
}
