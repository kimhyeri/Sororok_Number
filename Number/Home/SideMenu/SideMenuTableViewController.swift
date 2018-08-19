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
    var newsData = ["넥터13기 그룹의 남수민님의 번호가 변경되었습니다! 새롭게 업데이트 해주세요.",
                    "소로록이 새롭게 업데이트가 되었습니다!",
                    "넥터13기 그룹이 새롭게 추가되었습니다!",
                    "어서오세요:) 소로록에 오신것을 환영합니다."]
    
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
        cell.newsView.layer.cornerRadius = 10
        return cell
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

class SideMenuCell: UITableViewCell {
    
    @IBOutlet weak var newsView: UIView!
    @IBOutlet weak var news: UILabel!
}
