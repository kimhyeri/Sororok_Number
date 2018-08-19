//
//  GroupCreateViewController.swift
//  Number
//
//  Created by hyerikim on 2018. 7. 28..
//  Copyright © 2018년 nexters.number. All rights reserved.
//

import UIKit

class GroupCreateViewController: UIViewController {

    @IBOutlet weak var groupImage: UIImageView!
    @IBOutlet weak var groupView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        groupImage.backgroundColor = .black
        groupView.layer.cornerRadius = 10
    }

    @IBAction func clipButtonPressed(_ sender: Any) {
        
//        let alert = UIAlertController(title: "Test Title", message: "Custom Fonts in Alert Controller", preferredStyle: .actionSheet)
//        let strAction = NSMutableAttributedString(string: "Presenting the great...")
//        strAction.addAttribute(NSAttributedStringKey.font, value: UIFont.systemFont(ofSize: 30), range: NSMakeRange(24, 11))
//        alert.setValue(action, forKey: "attributedMessage")
//
        
        
        let alert = UIAlertController(title: nil, message: "그룹 코드번호가 클립보드에 복사되었습니다.", preferredStyle: .alert)
        
        let OKAlert = UIAlertAction(title: "OK", style: UIAlertActionStyle.default){
            (result: UIAlertAction) in
            alert.removeFromParentViewController()
        }
    
        alert.addAction(OKAlert)
        present(alert,animated: true, completion: nil)
    }
    
    @IBAction func AlbumPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "MyPage", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Album") as! AlbumViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
}
