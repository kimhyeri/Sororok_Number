//
//  ManagerGroupViewController.swift
//  Number
//
//  Created by hyerikim on 2018. 8. 21..
//  Copyright © 2018년 nexters.number. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ManagerGroupViewController: UIViewController{

    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var changeCodeView: UIView!
    
    var manager: [String] = ["그룹 공유하기", "그룹원 관리", "관리자 변경", "그룹 폭파"]
    var member: [String] = ["그룹 공유하기", "그룹 나가기"]
    
    override func viewWillAppear(_ animated: Bool) {
        getCodeNum()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        defualtView()
    }
    
    @IBAction func changeCodeButtonPressed(_ sender: Any) {
        let parameter = [
            "repositoryId" : ContactsViewController.repoId
        ]
        
        APICollection.sharedAPI.updateRepo(parameter: parameter as Parameters, completion: {
            (result) -> (Void) in
            self.codeLabel.text = result["groupCode"].stringValue
        })
    }
    
    func getCodeNum(){
        let parameter = [
            "repositoryId" : ContactsViewController.repoId
        ]
        
        APICollection.sharedAPI.getRepoInfo(parameter: parameter as Parameters, completion: { (result)-> (Void) in
            self.codeLabel.text = result["code"].stringValue
        })
    }
}
