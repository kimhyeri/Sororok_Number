//
//  LogoutViewController.swift
//  Number
//
//  Created by hyerikim on 2018. 8. 20..
//  Copyright © 2018년 nexters.number. All rights reserved.
//

import UIKit

class LogoutViewController: UIViewController {

    @IBOutlet weak var logoutView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        logoutView.layer.cornerRadius = 10
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logoutButtonPressed(_ sender: UIButton) {
        
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }


}
