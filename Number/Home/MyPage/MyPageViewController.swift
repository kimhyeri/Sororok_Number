//
//  MyPageViewController.swift
//  Number
//
//  Created by hyerikim on 2018. 7. 23..
//  Copyright © 2018년 nexters.number. All rights reserved.
//

import UIKit

class MyPageViewController: UIViewController {

    @IBOutlet weak var myImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myImage.layer.cornerRadius = myImage.frame.width/2
        myImage.backgroundColor = .black
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }

    @IBAction func buttonPressed(_ sender: Any) {
        let popUp = UIStoryboard(name: "Logout", bundle: nil).instantiateViewController(withIdentifier: "Logout") as! LogoutViewController
        popUp.modalPresentationStyle = .overCurrentContext
        self.present(popUp, animated: false, completion: nil)
    }
}
