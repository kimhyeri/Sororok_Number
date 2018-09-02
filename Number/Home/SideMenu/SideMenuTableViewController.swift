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

    //api 통신전 임시 데이터
    var newsData :[String] = ["넥터13기 그룹의 남수민님의 번호가 변경되었습니다! 새롭게 업데이트 해주세요.",
                              "소로록이 새롭게 업데이트가 되었습니다!",
                              "넥터13기 그룹이 새롭게 추가되었습니다!",
                              "어서오세요:) 소로록에 오신것을 환영합니다."]
    
    var historyData : HistoryDataSet!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData(memberId: UserDefaults.standard.integer(forKey: "memberId"))
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if newsData.count == 0 {
            return 1
        }
        return newsData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SideMenuCell
        if newsData.count == 0 {
            cell.iconImage.image = UIImage(named: "icnNoticeEmpty")
            cell.news.text = "최근 소식이 없습니다."
            cell.newsTimeLabel.text = " "
        }else {
            cell.iconImage.image = UIImage(named: "icnNotiNotice")
            cell.news.text = newsData[indexPath.row]
            //cell.newsTimeLabel.text = 시간
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
            print(self.historyData)
            print("result \(result)")
        })
    }
}



class SideMenuCell: UITableViewCell {
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var news: UILabel!
    @IBOutlet weak var newsTimeLabel: UILabel!
}
