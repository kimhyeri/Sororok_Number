//
//  GroupCreateView.swift
//  Number
//
//  Created by hyerikim on 08/10/2018.
//  Copyright © 2018 nexters.number. All rights reserved.
//

import Foundation

//MARK: setting default view
extension GroupCreateViewController {
    
    func defaultView(){
        initNav()
        settingButton()
        
        self.title = "그룹생성"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        groupBackView.clipsToBounds = true
        groupBackView.layer.cornerRadius = self.groupBackView.frame.width/2
        
        groupCode.layer.cornerRadius = 10
        groupImage.backgroundColor = .black
        groupImage.layer.cornerRadius = self.groupImage.frame.width/2
        groupView.layer.cornerRadius = 10
        
    }
    
    func settingButton() {
        let saveButton = UIBarButtonItem(title: "저장",  style: .plain, target: self, action: #selector(self.saveButton))
        self.navigationItem.rightBarButtonItem = saveButton
    }
}
