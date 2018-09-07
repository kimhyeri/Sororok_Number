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
        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    func changeView(){
        if UserDefaults.standard.integer(forKey: "authority") == 0 {
            titleLabel.text = "정말 그룹을 나가시려구요?"
            descLabel.text = """
            그룹 탈퇴에 대한 알림은
            그룹원에게 알림이 가지 않습니다.
            """
            delete.frame = CGRect(x: delete.frame.origin.x, y: delete.frame.origin.y, width: self.view.frame.width, height: delete.frame.height)
            change.alpha = 0
        }
        
    }

    @IBAction func Delete(_ sender: Any) {
        let parameter = [
            "memberId" : UserDefaults.standard.integer(forKey: "memberId"),
            "repositoryId" : ContactsViewController.repoId
        ]
        
        if UserDefaults.standard.integer(forKey: "authority") == 0 {
              APICollection.sharedAPI.exitRepo(parameters: parameter, completion: {
                (result) -> (Void) in
                let storyboard = UIStoryboard.init(name: "CodeNum", bundle: nil)
                let bv = storyboard.instantiateViewController(withIdentifier: "ST") as! CustomNaviViewController
                self.present(bv, animated: true, completion: nil)
          })
        } else {
            APICollection.sharedAPI.destroyRepo(parameters: parameter, completion: { (result) -> (Void) in
                let storyboard = UIStoryboard.init(name: "CodeNum", bundle: nil)
                let bv = storyboard.instantiateViewController(withIdentifier: "ST") as! CustomNaviViewController
                self.present(bv, animated: true, completion: nil)
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
