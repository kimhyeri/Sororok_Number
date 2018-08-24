//
//  DeleteViewController.swift
//  Number
//
//  Created by hyerikim on 2018. 7. 28..
//  Copyright © 2018년 nexters.number. All rights reserved.
//

import UIKit

class DeleteViewController: UIViewController {

    @IBOutlet weak var deleteView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        deleteView.layer.cornerRadius = 10
    }
    
    @IBAction func logoutButton(_ sender: Any) {
       self.dismiss(animated: false, completion: nil)
    }
}
