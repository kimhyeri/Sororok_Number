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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        defaultView()
    }
    
    func defaultView(){
        initNav()
        self.title = "그룹생성"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        let saveButton = UIBarButtonItem(title: "저장",  style: .plain, target: self, action: #selector(self.saveButton))
        self.navigationItem.rightBarButtonItem = saveButton
        groupCode.layer.cornerRadius = 10
        groupImage.backgroundColor = .black
        groupImage.layer.cornerRadius = self.groupImage.frame.width/2
        groupView.layer.cornerRadius = 10
        
//        groupInfoText.attributedPlaceholder = NSAttributedString(string: "그룹명을 적어주세요", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
//        groupNameText.attributedPlaceholder = NSAttributedString(string: "그룹설명을 적어주세요", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        
        getCode()
    }
    
    func getCode() {
        APICollection.sharedAPI.createCode(completion: { (result) -> (Void) in
            self.codeLabel.text = result["code"].stringValue
        })
    }
    
    //Create repositroy
    @objc func saveButton(){
        let url = "http://45.63.120.140:40005/repository/create"
        
        let name = groupNameText.text!
        let code = groupCode.titleLabel?.text!
        let memberId = UserDefaults.standard.string(forKey: "memberId")
        let extraInfo = groupInfoText.text!
        //        let memberImage = UIImagePNGRepresentation(myImage.image!)

        
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append((name.data(using: String.Encoding.utf8, allowLossyConversion: false))!, withName: "name")
                multipartFormData.append((code?.data(using: String.Encoding.utf8, allowLossyConversion: false))!, withName: "code")
                multipartFormData.append((memberId?.data(using: .utf8, allowLossyConversion: false))!, withName: "memberId")
                multipartFormData.append((extraInfo.data(using: String.Encoding.utf8, allowLossyConversion: false))!, withName: "extraInfo")
                //                multipartFormData.append((memberImage.data(using: String.Encoding.utf8, allowLossyConversion: false))!, withName: "memberImage")

        },
            to: url,
            method: .put,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        print(response.result.value!)
                        print(response.result)
                    }
                case .failure(let encodingError):
                    print(encodingError)
                }
        })
        
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func clipButtonPressed(_ sender: UIButton) {
        copyToClipBoard(textToCopy: (codeLabel.text)!)

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
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        self.groupImage.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        print(info[UIImagePickerControllerOriginalImage])
        picker.dismiss(animated: false)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
 
    func copyToClipBoard(textToCopy: String) {
        UIPasteboard.general.string = textToCopy
    }
}

extension GroupCreateViewController : AlbumSelectionDelegate{
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
        groupImage.image = img
    }
}
