//
//  SideMenuView.swift
//  Number
//
//  Created by hyerikim on 08/10/2018.
//  Copyright © 2018 nexters.number. All rights reserved.
//

import Foundation

//MARK: manage tableview
extension SideMenuTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let count = historyData?.historyList.count {
            return count
        }else {
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
    
}
