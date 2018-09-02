//
//  DeleteViewController.swift
//  Number
//
//  Created by hyerikim on 2018. 7. 28..
//  Copyright © 2018년 nexters.number. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class DeleteViewController: UIViewController {

    @IBOutlet weak var deleteView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        deleteView.layer.cornerRadius = 10
    }
    
    @IBAction func logoutButton(_ sender: Any) {
       self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func memberRemove(_ sender: Any) {
        //멤버변수에 userdefault에 저장된 memberId로 지우기
        let memberId : Parameters = [
            "memberId" : 30
        ]
        
        APICollection.sharedAPI.memberRemove(parameter: memberId, completion: {(result) -> (Void) in
            
        })
    }
}
