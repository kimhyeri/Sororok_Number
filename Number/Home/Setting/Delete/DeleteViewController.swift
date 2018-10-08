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
        defaultView()
    }
    
    func defaultView() {
        deleteView.layer.cornerRadius = 10
    }
    
    @IBAction func logoutButton(_ sender: Any) {
       self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func memberRemove(_ sender: Any) {
        let memberId : Parameters = [
            "memberId" : UserDefaults.standard.integer(forKey: "memberId")
        ]
        
        APICollection.sharedAPI.memberRemove(parameter: memberId, completion: {(result) -> (Void) in
            UserDefaults.standard.set(false, forKey: "isLoggedIn")
            UserDefaults.standard.synchronize()
        })
    }
}
