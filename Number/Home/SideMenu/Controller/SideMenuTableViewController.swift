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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData(memberId: UserDefaults.standard.integer(forKey: "memberId"))
        tableView.rowHeight = UITableViewAutomaticDimension
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
            self.tableView.reloadData()
        })
    }
}

class SideMenuCell: UITableViewCell {
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var news: UILabel!
    @IBOutlet weak var newsTimeLabel: UILabel!
}
