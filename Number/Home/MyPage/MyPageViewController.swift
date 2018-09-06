//
//  MyPageViewController.swift
//  Number
//
//  Created by hyerikim on 2018. 7. 23..
//  Copyright © 2018년 nexters.number. All rights reserved.
//

import UIKit
import Photos
import SwiftyJSON
import Alamofire

class MyPageViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var textView: UIView!
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var numText: UITextField!
    
    var defaultFrame : CGRect?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNav()
        defaultView()
    }
    
    func defaultView(){
        nameText.delegate = self
        numText.delegate = self
        emailText.delegate = self
        
        self.title = "마이페이지"
        numText.text = UserDefaults.standard.string(forKey: "phone")
        emailText.text = UserDefaults.standard.string(forKey: "email")
        nameText.text = UserDefaults.standard.string(forKey: "name")
        
//        if let image =  UserDefaults.standard.string(forKey: "imageName") {
//            myImage.image = UIImage(data: image)
//        }
        
        defaultFrame = textView.frame
        nameText.attributedPlaceholder = NSAttributedString(string: "이름", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        emailText.attributedPlaceholder = NSAttributedString(string: "이메일", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        numText.attributedPlaceholder = NSAttributedString(string: "전화번호", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        myImage.layer.cornerRadius = myImage.frame.width/2
        myImage.backgroundColor = .black
        let saveButton = UIBarButtonItem(title: "저장",  style: .plain, target: self, action: #selector(self.saveButton))
        self.navigationItem.rightBarButtonItem = saveButton
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
        textView.frame = defaultFrame!
    }
    
    func convertBase64ToImage(imageString: String) -> UIImage {
        let imageData = Data(base64Encoded: imageString, options: Data.Base64DecodingOptions.ignoreUnknownCharacters)!
        return UIImage(data: imageData)!
    }
    
    @objc func saveButton(){
        let url = URL(string: "http://45.63.120.140:40005/member/update")
        
        //이미지 처리 해줘야 함
        let phone = numText.text!
        let name = nameText.text!
        let email = emailText.text!
        let memberId = UserDefaults.standard.string(forKey: "memberId")
        
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append((phone.data(using: String.Encoding.utf8, allowLossyConversion: false))!, withName: "phone")
                multipartFormData.append((name.data(using: String.Encoding.utf8, allowLossyConversion: false))!, withName: "name")
                multipartFormData.append((email.data(using: String.Encoding.utf8, allowLossyConversion: false))!, withName: "email")
                multipartFormData.append((memberId?.data(using: .utf8, allowLossyConversion: false))!, withName: "memberId")
                DispatchQueue.main.async {
                    multipartFormData.append(UIImageJPEGRepresentation(self.myImage.image!, 1)!, withName: "memberImage", fileName: "memberImage.jpeg", mimeType: "memberImage/jpeg")
                }

        },
            to: url!,
            method: .put,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        print(response.result.value!)
                        self.navigationController?.popViewController(animated: true)
                    }
                case .failure(let encodingError):
                    print(encodingError)
                }
        })
    }
    
    @IBAction func buttonPressed(_ sender: Any) {
        let popUp = UIStoryboard(name: "Logout", bundle: nil).instantiateViewController(withIdentifier: "Logout") as! LogoutViewController
        popUp.modalPresentationStyle = .overCurrentContext
        self.present(popUp, animated: false, completion: nil)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        viewUp()
    }
    
    func viewUp() {
        textView.frame = CGRect(x: 0, y: 65, width: self.view.frame.width, height: textView.frame.height)
    }
    
    @IBAction func albumButtonPressed(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = false
        self.present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        self.myImage.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        print(info[UIImagePickerControllerOriginalImage])
        picker.dismiss(animated: false)
    }
}

extension MyPageViewController : AlbumSelectionDelegate{
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
        myImage.image = img
    }
}

