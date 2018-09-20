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

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = historyData?.historyList.count {
            return count
        } else {
            return 1
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SideMenuCell
        if historyData?.historyList.count == 0 {
            cell.iconImage.image = UIImage(named: "icnNoticeEmpty")
            cell.news.text = "최근 소식이 없습니다."
            cell.newsTimeLabel.text = " "
        }else {
            cell.iconImage.image = UIImage(named: "icnNotiNotice")
            cell.news.text = self.historyData?.historyList[indexPath.row].content
            cell.newsTimeLabel.text = self.historyData?.historyList[indexPath.row].date
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
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
