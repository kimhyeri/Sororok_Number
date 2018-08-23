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
        defaultView()
    }
    
    func defaultView(){
        logoutView.layer.cornerRadius = 10
    }
    
    @IBAction func logoutButtonPressed(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Main")
        self.navigationController?.popToRootViewController(animated: true)
        UIApplication.shared.keyWindow?.rootViewController = vc
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }


}
