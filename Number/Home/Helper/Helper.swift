//
//  Helper.swift
//  Number
//
//  Created by hyerikim on 2018. 8. 24..
//  Copyright © 2018년 nexters.number. All rights reserved.
//

import Foundation

extension UIViewController {
    
    func initNav(){
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "btnCommBackWh")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "btnCommBackWh")
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }
    
}
