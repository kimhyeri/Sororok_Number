//
//  GroupCreateSendController.swift
//  Number
//
//  Created by hyerikim on 03/11/2018.
//  Copyright © 2018 nexters.number. All rights reserved.
//

import UIKit
import Alamofire

//MARK: create group (api)

extension GroupCreateViewController {
  
  @objc func saveButton(){
    
    let url = "http://45.63.120.140:40005/repository/create"
    
    guard groupNameText.text != "" else { showToast(message: "그룹명"); return }
    guard codeLabel.text != "" else { showToast(message: "코드번호 오류"); return}
    
    let memberId = UserDefaults.standard.string(forKey: "memberId")
    let extraInfo = groupInfoText.text ?? ""
    
    if let name = groupNameText.text {
      if let code = codeLabel.text {
        Alamofire.upload(
          multipartFormData: { multipartFormData in
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
                self.navigationController?.popViewController(animated: true)
              }
            case .failure(let encodingError):
              print(encodingError)
            }
        })
      }
    }
  }
}
