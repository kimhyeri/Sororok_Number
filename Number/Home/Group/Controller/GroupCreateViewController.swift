//
//  GroupCreateViewController.swift
//  Number
//
//  Created by hyerikim on 2018. 7. 28..
//  Copyright © 2018년 nexters.number. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class GroupCreateViewController: UIViewController {

    @IBOutlet weak var groupBackView: UIView!
    @IBOutlet weak var groupInfoText: UITextField!
    @IBOutlet weak var groupNameText: UITextField!
    @IBOutlet weak var groupCode: UIButton!
    @IBOutlet weak var groupImage: UIImageView!
    @IBOutlet weak var groupView: UIView!
    @IBOutlet weak var codeLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        getCode()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        defaultView()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
}


//MARK: manage group code

extension GroupCreateViewController {
    
    func getCode() {
        APICollection.sharedAPI.createCode(completion: { (result) -> (Void) in
            self.codeLabel.text = result["code"].stringValue
        })
    }
    
    @IBAction func clipButtonPressed(_ sender: UIButton) {
        if let codeNum = codeLabel.text {
            copyToClipBoard(textToCopy: codeNum)
        }
        
        let alert = UIAlertController(title: nil, message: "그룹 코드번호가 클립보드에 복사되었습니다.", preferredStyle: .alert)
        let OKAlert = UIAlertAction(title: "OK", style: UIAlertActionStyle.default){
            (result: UIAlertAction) in
            alert.removeFromParentViewController()
        }

        alert.addAction(OKAlert)
        present(alert,animated: true, completion: nil)
    }
    
    func copyToClipBoard(textToCopy: String) {
        UIPasteboard.general.string = textToCopy
    }
    
}
