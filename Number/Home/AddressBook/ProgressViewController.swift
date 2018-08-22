//
//  ProgressViewController.swift
//  Number
//
//  Created by hyerikim on 2018. 8. 22..
//  Copyright © 2018년 nexters.number. All rights reserved.
//

import UIKit

class ProgressViewController: UIViewController {

    @IBOutlet weak var iconView: UIView!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var currentLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        iconView.layer.cornerRadius = iconView.frame.width/2
    }
    

}
