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
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var delete: UIButton!
    @IBOutlet weak var change: UIButton!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        changeView()
        
    }

    func moveToCodeNum() {
        let storyboard = UIStoryboard.init(name: "CodeNum", bundle: nil)
        let bv = storyboard.instantiateViewController(withIdentifier: "ST") as! CustomNaviViewController
        self.present(bv, animated: true, completion: nil)
    }
    
    @IBAction func Delete(_ sender: Any) {
        let parameter = [
            "memberId" : UserDefaults.standard.integer(forKey: "memberId"),
            "repositoryId" : ContactsViewController.repoId
        ]
        
        if UserDefaults.standard.integer(forKey: "authority") == 0 {
              APICollection.sharedAPI.exitRepo(parameters: parameter, completion: {
                (result) -> (Void) in
                self.moveToCodeNum()
          })
        } else {
            APICollection.sharedAPI.destroyRepo(parameters: parameter, completion: { (result) -> (Void) in
                self.moveToCodeNum()
            })
        }
    }
    
    @IBAction func dismissButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func changeAdmin(_ sender: Any) {
        self.dismiss(animated: false, completion:nil)
    }
    

}
