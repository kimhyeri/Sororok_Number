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
//        self.navigationController?.navigationBar.tintColor = UIColor.init(hex: "343ACF")
//        self.navigationController?.navigationBar.isTranslucent = false
//        var image = UIImage(named: "btnCommBackWh")
//        image = image?.withRenderingMode(.alwaysOriginal)
//        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style:.plain, target: nil, action: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
