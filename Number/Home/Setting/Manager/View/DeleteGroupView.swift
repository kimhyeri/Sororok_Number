//
//  DeleteGroupView.swift
//  Number
//
//  Created by hyerikim on 08/10/2018.
//  Copyright © 2018 nexters.number. All rights reserved.
//

import Foundation

extension DeleteGroupViewController {
    
    func changeView(){
        if UserDefaults.standard.integer(forKey: "authority") == 0 {
            titleLabel.text = "정말 그룹을 나가시려구요?"
            descLabel.text = """
            그룹 탈퇴에 대한 알림은
            그룹원에게 알림이 가지 않습니다.
            """
            delete.frame = CGRect(x: delete.frame.origin.x, y: delete.frame.origin.y, width: self.view.frame.width, height: delete.frame.height)
            change.alpha = 0
        }
    }
    
}
