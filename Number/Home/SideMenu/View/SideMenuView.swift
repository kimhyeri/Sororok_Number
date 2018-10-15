//
//  SideMenuView.swift
//  Number
//
//  Created by hyerikim on 08/10/2018.
//  Copyright © 2018 nexters.number. All rights reserved.
//

import Foundation

//MARK: setting view
extension SideMenuTableViewController {
    func defaultView() {
        tableView.rowHeight = UITableViewAutomaticDimension
    }
}

//MARK: manage tableview
extension SideMenuTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (count != 0) ? count : 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! SideMenuTableViewCell
        if count == 0 {
            cell.iconImage.image = UIImage(named: "icnNoticeEmpty")
            cell.news.text = "최근 소식이 없습니다."
            cell.newsTimeLabel.text = " "
        } else {
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
