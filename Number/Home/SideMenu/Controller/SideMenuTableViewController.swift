//
//  SideMenuTableViewController.swift
//  Number
//
//  Created by hyerikim on 2018. 7. 28..
//  Copyright © 2018년 nexters.number. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class SideMenuTableViewController: UITableViewController {
    
    var historyData : HistoryDataSet?
    var count : Int = 0
    let cellId : String = "Cell"

    
    override func viewWillAppear(_ animated: Bool) {
        loadData(memberId: UserDefaults.standard.integer(forKey: "memberId"))
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        defaultView()
    
    }
    
    @IBAction func exitButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func loadData(memberId: Int) {
        let memberId : Parameters = [
            "memberId" : memberId
        ]
        
        APICollection.sharedAPI.memberHistory(parameter: memberId, completion: {(result) -> (Void) in
            
            self.historyData = HistoryDataSet(rawJson: result)
            if var history = self.historyData {
                self.count = history.historyList.count
            }
            self.tableView.reloadData()
        })
    }
    
}
