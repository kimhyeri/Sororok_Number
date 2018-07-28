//
//  SideMenuTableViewController.swift
//  Number
//
//  Created by hyerikim on 2018. 7. 28..
//  Copyright © 2018년 nexters.number. All rights reserved.
//

import UIKit

class SideMenuTableViewController: UITableViewController {

    //api 통신전 임시 데이터
    var newsData = ["새로운 뉴스입니다아아아어떤게 어떤게 어떤게",
                    "새로운 그룹에 초대되셨습니다.",
                    "방장이 그룹을 파괴하셨스빈다."]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    //알림 소식 만큼
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SideMenuCell
        cell.news.text = newsData[indexPath.row]
        cell.news.textColor = .darkGray
        return cell
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

class SideMenuCell: UITableViewCell {
    
    @IBOutlet weak var news: UILabel!
}
