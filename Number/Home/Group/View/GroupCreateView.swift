//
//  GroupCreateView.swift
//  Number
//
//  Created by hyerikim on 08/10/2018.
//  Copyright © 2018 nexters.number. All rights reserved.
//

import Foundation

extension GroupCreateViewController {
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
        
    }
}
