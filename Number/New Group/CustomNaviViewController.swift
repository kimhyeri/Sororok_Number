//
//  CustomNaviViewController.swift
//  Number
//
//  Created by hyerikim on 2018. 7. 29..
//  Copyright © 2018년 nexters.number. All rights reserved.
//

import UIKit

class CustomNaviViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
