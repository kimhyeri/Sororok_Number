//
//  ManagerViewController.swift
//  Number
//
//  Created by hyerikim on 2018. 7. 28..
//  Copyright © 2018년 nexters.number. All rights reserved.
//

import UIKit

class ManagerViewController: UIViewController {

    @IBOutlet weak var mentView: UIView!
    @IBOutlet weak var becomeManagerView: UIView!
    @IBOutlet weak var beforeManager: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        becomeManagerView.layer.cornerRadius = becomeManagerView.frame.width/2
        mentView.layer.cornerRadius = 10
        beforeManager.layer.cornerRadius = beforeManager.frame.width/2
        self.navigationController?.navigationBar.topItem?.title = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
