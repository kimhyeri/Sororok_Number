//
//  ManagerViewController.swift
//  Number
//
//  Created by hyerikim on 2018. 7. 28..
//  Copyright © 2018년 nexters.number. All rights reserved.
//

import UIKit

class ManagerViewController: UIViewController {

    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var mentView: UIView!
    @IBOutlet weak var becomeManagerView: UIView!
    @IBOutlet weak var beforeManager: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        defaultView()
    }

}
