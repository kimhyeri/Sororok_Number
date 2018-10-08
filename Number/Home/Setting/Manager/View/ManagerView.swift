//
//  ManagerView.swift
//  Number
//
//  Created by hyerikim on 08/10/2018.
//  Copyright © 2018 nexters.number. All rights reserved.
//

import Foundation

extension ManagerViewController {
    func defaultView() {
        becomeManagerView.layer.cornerRadius = becomeManagerView.frame.width/2
        mentView.layer.cornerRadius = 10
        beforeManager.layer.cornerRadius = beforeManager.frame.width/2
        myImage.layer.cornerRadius = myImage.frame.width/2
        
        self.navigationController?.navigationBar.topItem?.title = ""
    }
}
