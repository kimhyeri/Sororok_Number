//
//  AlertTwoView.swift
//  Number
//
//  Created by hyerikim on 2018. 9. 19..
//  Copyright © 2018년 nexters.number. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


//MARK: AlertViewController Custom

extension TwoViewController {
    func createAlert(data: Int){
        let alert = UIAlertController(title: "그룹 코드를 입력해주세요", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "코드 입력"
            textField.clearButtonMode = .whileEditing
            textField.borderStyle = .none
        }
        
        let noAlert = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default){
            (result: UIAlertAction) in
            alert.removeFromParentViewController()
        }
        let okAlert = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default){
            (result: UIAlertAction) in
            
            let parameter : Parameters = [
                "code" : alert.textFields![0].text!,
                "memberId" : UserDefaults.standard.integer(forKey: "memberId"),
                "repositoryId" : data
            ]
            
            Alamofire.request("http://45.63.120.140:40005/repository/join", method: .put, parameters: parameter, encoding: JSONEncoding.default, headers: [:]).responseJSON {
                response in
                let json = JSON(response.result.value)
                print(json)
                switch response.result {
                case .success:
                    print("success")
                    if json["repositoryId"] == -1 {
                        self.showToast(message: "코드번호 불일치")
                    } else {
                        let storyboard = UIStoryboard.init(name: "DetailHome", bundle: nil)
                        let nv = storyboard.instantiateViewController(withIdentifier: "NV") as! ContactNaviViewController
                        ContactsViewController.repoId = data
                        self.present(nv, animated: true, completion: nil)
                        break
                    }
                    
                case .failure:
                    print("fail")
                    
                    break
                }
            }
        }
        alert.addAction(noAlert)
        alert.addAction(okAlert)
        present(alert,animated: true, completion: nil)
    }
}
