//
//  ContactViewNotiController.swift
//  Number
//
//  Created by hyerikim on 12/10/2018.
//  Copyright © 2018 nexters.number. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

//MARK: Notifications
extension ContactsViewController {
    
    func createObserver(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.searchMemberNoti(_:)), name: searchMember, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.searchMemberDoneNoti), name: searchMemberDone, object: nil)
    }
    
    @objc func searchMemberDoneNoti(){
        nothingView.alpha = 0
        self.selectButton.isEnabled = true
        self.selectAllbutton.isEnabled = true
        
        let parameter = [
            "repositoryId" : ContactsViewController.repoId
        ]
        
        APICollection.sharedAPI.getRepoMember(parameter: parameter) { (result) -> (Void) in
            self.memberList = DetailMemberSet(rawJson: result)
            if let count = self.memberList?.memberList.count {
                self.totalLabel.text = "총 \(count)명"
            }
            self.tableView.reloadData()
        }
    }
    
    @objc func searchMemberNoti(_ notification: Notification){
        
        if let data = notification.userInfo as? [String: String]
        {
            for (_, text) in data
            {
                searchText = text
            }
        }
        guard searchText != nil else{return}
        
        let parameter : Parameters = [
            "memberName" : searchText!,
            "repositoryId" : ContactsViewController.repoId
        ]
        
        Alamofire.request("http://45.63.120.140:40005/repository/memberSearch", method: .get, parameters: parameter).responseJSON { response in
            let json = JSON(response.result.value)
            switch response.result {
            case .success:
                print("search success")
                self.memberList = DetailMemberSet(rawJson: json)
                self.view.endEditing(true)
                if self.memberList?.memberList.count != 0 {
                    self.tableView.reloadData()
                }else{
                    self.nothingView.alpha = 1
                    self.selectButton.isEnabled = false
                    self.selectAllbutton.isEnabled = false
                }
                break
            case .failure:
                print("fail")
                break
            }
        }
    }
}
