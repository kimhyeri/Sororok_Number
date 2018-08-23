//
//  DeleteGroupViewController.swift
//  Number
//
//  Created by hyerikim on 2018. 8. 24..
//  Copyright © 2018년 nexters.number. All rights reserved.
//

import UIKit

class DeleteGroupViewController: UIViewController {

    @IBOutlet weak var constraintY: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded()
        })
    }

    @IBAction func Delete(_ sender: Any) {
        let storyboard = UIStoryboard.init(name: "CodeNum", bundle: nil)
        let bv = storyboard.instantiateViewController(withIdentifier: "ST") as! CustomNaviViewController
        self.present(bv, animated: true, completion: nil)
    }
    
    @IBAction func changeAdmin(_ sender: Any) {
        self.dismiss(animated: false, completion:nil)
    }
    

}
