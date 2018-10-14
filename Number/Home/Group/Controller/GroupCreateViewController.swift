//
//  GroupCreateViewController.swift
//  Number
//
//  Created by hyerikim on 2018. 7. 28..
//  Copyright © 2018년 nexters.number. All rights reserved.
//

import UIKit
import Photos
import SwiftyJSON
import Alamofire

class GroupCreateViewController: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet weak var groupInfoText: UITextField!
    @IBOutlet weak var groupNameText: UITextField!
    @IBOutlet weak var groupCode: UIButton!
    @IBOutlet weak var groupImage: UIImageView!
    @IBOutlet weak var groupView: UIView!
    @IBOutlet weak var codeLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        getCode()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        defaultView()
    }
    
    func getCode() {
        APICollection.sharedAPI.createCode(completion: { (result) -> (Void) in
            self.codeLabel.text = result["code"].stringValue
        })
    }
    
    @objc func saveButton(){
      
        let url = "http://45.63.120.140:40005/repository/create"
        
        guard groupNameText.text != nil else {showToast(message: "이름 입력해주세요"); return}
        guard codeLabel.text != nil else {showToast(message: "fail"); return}
        guard groupInfoText.text != nil else {showToast(message: "그룹설명 입력해주세요"); return}
        
        let name = groupNameText.text!
        let code = codeLabel.text!
        let extraInfo = groupInfoText.text!
        let memberId = UserDefaults.standard.string(forKey: "memberId")
        let image = imageChange() as Data
        
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append(image, withName: "memberImage", fileName: "memberImage.jpeg", mimeType: "memberImage/jpeg")
                multipartFormData.append((name.data(using: String.Encoding.utf8, allowLossyConversion: false))!, withName: "name")
                multipartFormData.append((code.data(using: String.Encoding.utf8, allowLossyConversion: false))!, withName: "code")
                multipartFormData.append((memberId?.data(using: .utf8, allowLossyConversion: false))!, withName: "memberId")
                multipartFormData.append((extraInfo.data(using: String.Encoding.utf8, allowLossyConversion: false))!, withName: "extraInfo")

        },
            to: url,
            method: .put,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        let reloadTable = Notification.Name(rawValue: reloadTalbeViewKey )
                        NotificationCenter.default.post(name: reloadTable, object: nil)
                    }
                case .failure(let encodingError):
                    print(encodingError)
                }
        })
        
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func clipButtonPressed(_ sender: UIButton) {
        if let codeNum = codeLabel.text {
            copyToClipBoard(textToCopy: codeNum)
        }
        
        let alert = UIAlertController(title: nil, message: "그룹 코드번호가 클립보드에 복사되었습니다.", preferredStyle: .alert)
        let OKAlert = UIAlertAction(title: "OK", style: UIAlertActionStyle.default){
            (result: UIAlertAction) in
            alert.removeFromParentViewController()
        }

        alert.addAction(OKAlert)
        present(alert,animated: true, completion: nil)
    }
    
    @IBAction func AlbumPressed(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = false
        self.present(picker, animated: true)
    }
    
    func imageChange() -> NSData {
        let image : UIImage = groupImage.image!
        let imageData:NSData = UIImagePNGRepresentation(image)! as NSData
        _ = imageData.base64EncodedString(options: .lineLength64Characters)
        return imageData
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        self.groupImage.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        picker.dismiss(animated: false)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
 
    func copyToClipBoard(textToCopy: String) {
        UIPasteboard.general.string = textToCopy
    }
}
